import UIKit

class MakerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var subjectsController:SubjectsController = SubjectsController()
    var subjects: [Subject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subjectsController.loadSubjects()
        subjects = subjectsController.subjects
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        subjectsController.saveSubjects()
    }

    
    // Return the number of rows for the table.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }

    // Provide a cell object for each row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        // Fetch a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell(withIdentifier: "makerCell", for: indexPath)
       // Configure the cell’s contents.
        cell.textLabel!.text = subjects[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let subjectToMove = subjects.remove(at: sourceIndexPath.row)
        subjects.insert(subjectToMove, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            subjects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .none)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "subjectToGroups", sender: indexPath)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? GroupsTableViewController, let indexPath = sender as? IndexPath {
            vc.subjectsController = self.subjectsController
            vc.subjectIndex = indexPath.row
        }
    }
    
}

