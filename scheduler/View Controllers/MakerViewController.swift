import UIKit

class MakerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var subjectsController:SubjectsController = SubjectsController()
    var subjects: [Subject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.setEditing(false, animated: false)
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subjectsController.loadSubjects()
        subjects = subjectsController.subjects
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        subjectsController.saveSubjects()
    }

    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
        let subject = subjects[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = subject.name
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let subjectToMove = subjects.remove(at: sourceIndexPath.row)
        subjects.insert(subjectToMove, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            subjects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
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
    
    func addSubjectAlertController(){
        let alertController = UIAlertController(title: "Add Subject", message: "Enter subject's name", preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: {textField in textField.placeholder = "Example: Calculus"})
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        let ok = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in self.checkSubjectName(alertController.textFields?.first?.text ?? "", false)})
  
        alertController.addAction(ok)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func checkSubjectName(_ name: String,_ exists: Bool){
        if(!name.isEmpty && !exists){
            let subject = Subject(name: name)
            let newIndexPath = IndexPath(row: subjects.count, section: 0)
            subjects.append(subject)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    @IBAction func addSubjectButtonTapped(_ sender: UIBarButtonItem) {
        addSubjectAlertController()
    }
    
}

