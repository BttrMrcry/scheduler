import UIKit

class GroupsTableViewController: UITableViewController {
    var subject: Subject?
    var subjectController: SubjectsController?
    var selectedIndexPath: IndexPath?
    
    init?(coder: NSCoder, subject: Subject?, subjectController: SubjectsController?, selectedIndexPath: IndexPath?) {
        self.subject = subject
        self.subjectController = subjectController
        self.selectedIndexPath = selectedIndexPath
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        self.subject = nil
        self.subjectController = nil
        self.selectedIndexPath = nil
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItems?[1] = editButtonItem
        self.navigationItem.title = subject?.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        subjectController!.subjects[selectedIndexPath!.row] = subject!
        subjectController!.saveSubjects()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subject!.groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath)
        let group = subject!.groups[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = group.groupID
        content.secondaryText = "Professor: \(group.profesorName)   Slots: \(group.slots)"
        cell.contentConfiguration = content
        cell.showsReorderControl = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let subjectToMove = subject!.groups.remove(at: sourceIndexPath.row)
        subject!.groups.insert(subjectToMove, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            subject!.groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .none)
        }
    }
    
    @IBSegueAction func addEditGroup(_ coder: NSCoder, sender: Any?) -> AddGroupTableViewController? {
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell){
            let groupToEdit = subject?.groups[indexPath.row]
            return AddGroupTableViewController(coder: coder, group: groupToEdit, subjectName: subject?.name ?? " ")
        } else {
            
            return AddGroupTableViewController(coder: coder, group: nil, subjectName: subject?.name ?? " ")
        }
    }
    
    @IBAction func unwindToGroupTableView(segue: UIStoryboardSegue){
        guard segue.identifier == "saveUnwind",
              let sourceViewController = segue.source as? AddGroupTableViewController,
              let group = sourceViewController.group else { return }
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            subject?.groups[selectedIndexPath.row] = group
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else {
            let newIndexPath = IndexPath(row: subject!.groups.count, section: 0)
            subject?.groups.append(group)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    
}
