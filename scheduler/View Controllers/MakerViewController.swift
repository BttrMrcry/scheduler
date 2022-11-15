import UIKit

class MakerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var subjectsController = SubjectsController()
    var schedulesController = SchedulesController()
    var subjects: [Subject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        subjectsController.loadSubjects()
        subjects = subjectsController.subjects
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        subjectsController.subjects = subjects
        subjectsController.saveSubjects()
    }
    
    func addSubjectAlertController(){
        let alertController = UIAlertController(title: "Add Subject", message: "Enter subject's name", preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: {textField in textField.placeholder = "Example: Calculus"})
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        let ok = UIAlertAction(title: "Ok", style: .default, handler: {
            (action) -> Void in
            let subjectName = alertController.textFields?.first?.text ?? ""
            for curSubject in self.subjects {
                if subjectName == curSubject.name {
                    let usedNameAlertController = UIAlertController(title: "Name already used", message: "The typed name is already in use by another subject, try another one", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    usedNameAlertController.addAction(ok)
                    self.present(usedNameAlertController, animated: true, completion: nil)
                    return
                }
            }
            self.checkSubjectName(subjectName, false)
        })
        
        
  
        alertController.addAction(ok)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
        
        
    }
    

    
//    TODO: Look for repeated subject names
    func checkSubjectName(_ name: String,_ isEditing: Bool){
        if(!name.isEmpty && !isEditing){
            let subject = Subject(name: name)
            let newIndexPath = IndexPath(row: subjects.count, section: 0)
            subjects.append(subject)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
    @IBAction func addSubjectButtonTapped(_ sender: UIBarButtonItem) {
        addSubjectAlertController()
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
        content.secondaryText = "Groups: \(subject.groups.count)"
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let subjectToMove = subjects.remove(at: sourceIndexPath.row)
        subjects.insert(subjectToMove, at: destinationIndexPath.row)
        subjectsController.saveSubjects()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            subjects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            subjectsController.saveSubjects()
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
    }
        
    // MARK: - Navigation
    
    @IBSegueAction func subjectToGroup(_ coder: NSCoder, sender: Any?) -> GroupsTableViewController? {
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            let subjectToEdit = subjects[indexPath.row]
            return GroupsTableViewController(coder: coder, subject: subjectToEdit, subjectController: subjectsController, selectedIndexPath: indexPath)
        } else {
            return GroupsTableViewController(coder: coder, subject: nil, subjectController: nil, selectedIndexPath: nil)
        }
    }
    
    func genetateSchedulesButton() {
        var scheduler = Scheduler()
        schedulesController.currentSchedules = scheduler.makeSchedules(subjects: subjectsController.subjects)
        print("horarios generados")
    }
    
    @IBSegueAction func showGeneratedSchedules(_ coder: NSCoder) -> UITableViewController? {
        
        genetateSchedulesButton()

        
        let nextTableView = SchedulesListTableViewController(coder: coder, schedulesController: self.schedulesController)
        return nextTableView
    }
}
