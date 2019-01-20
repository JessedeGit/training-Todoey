//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Owner on 17/1/19.
//  Copyright © 2019 Jesse-Team. All rights reserved.
//

import UIKit
import RealmSwift
//import SwipeCellKit

class CategoryViewController: SwipeTableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var addButton: UIBarButtonItem?
    
    let realm = try! Realm()
    
    var categories: Results<Category>!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80.0
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        loadData()
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categries added yet!"
        return cell
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            let newItem = Category()
            newItem.name = textField.text!
            self.save(category: newItem)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func save(category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Line was seleceted!")
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destiVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destiVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    func loadData(){
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let category = self.categories?[indexPath.row]{
            do {
                try self.realm.write {
                    self.realm.delete(category)
                }
            }catch {
                print("Error saving context \(error)")
            }
        }
    }
}


