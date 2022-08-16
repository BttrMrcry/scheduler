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
        for i in stride(from: 0, to: subjectArray.count, by: 1){
            if subjectArray[i].isOpen {
                subjectArray[i].isOpen = false
                let sections = IndexSet.init(integer: i)
                tableView.reloadSections(sections, with: .none)
            }
        }
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return subjectArray.count
    }
    
    
    // Return the number of rows for the table.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if subjectArray[section].isOpen {
            return subjectArray[section].Groups.count + 1
        }else {
            return 1
        }
    }

    // Provide a cell object for each row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            
            // Fetch a cell of the appropriate type.
            let cell = tableView.dequeueReusableCell(withIdentifier: "makerCell", for: indexPath)
           // Configure the cell’s contents.
            cell.textLabel!.text = subjectArray[indexPath.section].name
            if tableView.isEditing {
                cell.showsReorderControl = true
            }else{
                cell.showsReorderControl = false
            }
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "groupCellMaker", for: indexPath)
            cell.textLabel!.text = "Group: " + String(subjectArray[indexPath.section].Groups[indexPath.row - 1].number)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let subjectToMove = subjectArray.remove(at: sourceIndexPath.section)
        subjectArray.insert(subjectToMove, at: destinationIndexPath.section)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.subjectArray.remove(at: indexPath.section)
            let sections = IndexSet.init(integer: indexPath.section)
            self.tableView.deleteSections(sections, with: .none)
        }
    }
    
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            if subjectArray[indexPath.section].isOpen {
                subjectArray[indexPath.section].isOpen = false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }else{
                subjectArray[indexPath.section].isOpen = true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }
        
        
        
    }
}

