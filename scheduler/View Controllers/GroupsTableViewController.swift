import UIKit

class GroupsTableViewController: UITableViewController {
    var subject: Subject?
    
    init?(coder: NSCoder, subject: Subject?) {
        self.subject = subject
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        self.subject = nil
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
        content.secondaryText = "Professor: \(group.profesorName)   Classroom: \(group.room)"
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
    

    
    
}
