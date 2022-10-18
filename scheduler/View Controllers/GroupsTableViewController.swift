//
//  GroupsMakerTableViewController.swift
//  scheduler
//
//  Created by rl on 10/08/22.
//

import UIKit

class GroupsTableViewController: UITableViewController {
    var subjectsController:SubjectsController!
    var subjectIndex:Int!
//    @IBOutlet weak var editButton: UIBarButtonItem!
//    @IBAction func editButtonTapped(_ sender: UIBarButtonItem){
//        let tableViewEditMode = tableView.isEditing
//        if tableViewEditMode {
//            editButton.title = "Editar"
//        }else{
//            editButton.title = "Listo"
//        }
//        print(tableView.isEditing)
//        tableView.setEditing(!tableViewEditMode, animated: true)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItems?[1] = editButtonItem
        self.navigationItem.title = subjectsController.subjects[subjectIndex].name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectsController.subjects[subjectIndex].groups.count
    }

    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath)
        cell.textLabel!.text = subjectsController.subjects[subjectIndex].groups[indexPath.row].groupID
        
        if tableView.isEditing {
            cell.showsReorderControl = true
        }else{
            cell.showsReorderControl = false
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let subjectToMove = subjectsController.subjects[subjectIndex].groups.remove(at: sourceIndexPath.row)
        subjectsController.subjects[subjectIndex].groups.insert(subjectToMove, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            subjectsController.subjects[subjectIndex].groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .none)
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
    }
}
