//
//  ViewController.swift
//  scheduler
//
//  Created by rl on 04/08/22.
//

import UIKit




class MakerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    
    var subjectArray = [Subject(name: "Calculus"), Subject(name:"EDA"), Subject(name:"POO"), Subject(name: "Circuits"), Subject(name:"AI")]
    
    
    @IBAction func EditButtonTapped(_ sender: UIBarButtonItem) {
        
        let tableViewEditMode = tableView.isEditing
        if tableViewEditMode {
            editButton.title = "Editar"
        }else{
            editButton.title = "Listo"
        }
        
        tableView.setEditing(!tableViewEditMode, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    

    
    // Return the number of rows for the table.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectArray.count
    }

    // Provide a cell object for each row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        // Fetch a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell(withIdentifier: "makerCell", for: indexPath)
       // Configure the cell’s contents.
        cell.textLabel!.text = subjectArray[indexPath.row].name
        if tableView.isEditing {
            cell.showsReorderControl = true
        }else{
            cell.showsReorderControl = false
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let subjectToMove = subjectArray.remove(at: sourceIndexPath.row)
        subjectArray.insert(subjectToMove, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.subjectArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .none)
        }
    }

}

