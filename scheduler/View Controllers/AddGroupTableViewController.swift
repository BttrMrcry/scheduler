import UIKit

class AddGroupTableViewController: UITableViewController, SelectDaysTableViewControllerDelegate {

    @IBOutlet weak var groupIDTextField: UITextField!
    @IBOutlet weak var professorTextField: UITextField!
    @IBOutlet weak var slotsTextField: UITextField!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var startTimeDatePicker: UIDatePicker!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var endTimeDatePicker: UIDatePicker!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    let startTimeDateLabelCellIndexPath = IndexPath(row: 0, section: 2)
    let startTimeDatePickerCellIndexPath = IndexPath(row: 1, section: 2)
    let endTimeDateLabelCellIndexPath = IndexPath(row: 2, section: 2)
    let endTimeDatePickerCellIndexPath = IndexPath(row: 3, section: 2)
    
    var isStartTimeDatePickerVisible: Bool = false {
        didSet {
            startTimeDatePicker.isHidden = !isStartTimeDatePickerVisible
        }
    }
    
    var isEndTimeDatePickerVisible: Bool = false {
        didSet {
            endTimeDatePicker.isHidden = !isEndTimeDatePickerVisible
        }
    }
    
    var group: Group?
    var subjectName: String?
    var days: Set<Int>
    
    init?(coder: NSCoder, group: Group?, subjectName: String?) {
        self.group = group
        self.days = Set()
        self.subjectName = subjectName
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        self.group = nil
        self.days = Set()
        self.subjectName = nil
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimeDatePicker.minimumDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())
        startTimeDatePicker.maximumDate = Calendar.current.date(bySettingHour: 23, minute: 30, second: 0, of: Date())
        endTimeDatePicker.maximumDate = Calendar.current.date(bySettingHour: 23, minute: 45, second: 0, of: Date())

        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
        
        
        if let group = group {
            groupIDTextField.text = group.groupID
            professorTextField.text = group.profesorName
            slotsTextField.text = "\(group.slots)"
            daysLabel.text = formattedDays(group.getDays())
            startTimeLabel.text = group.getStartTime().formatted(date: .omitted, time: .shortened)
            endTimeLabel.text = group.getEndTime().formatted(date: .omitted, time: .shortened)
            startTimeDatePicker.date = group.getStartTime()
            endTimeDatePicker.date = group.getEndTime()
            days = group.getDays()
            title = "Edit Group"
        } else {
            title = "New Group Registration"
            days = Set()
        }
        updateViews()
        updateSaveButtonState()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case startTimeDatePickerCellIndexPath where isStartTimeDatePickerVisible == false:
            return 0
        case endTimeDatePickerCellIndexPath where isEndTimeDatePickerVisible == false:
            return 0
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case startTimeDatePickerCellIndexPath:
            return 190
        case endTimeDatePickerCellIndexPath:
            return 190
        default:
            return UITableView.automaticDimension
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath == startTimeDateLabelCellIndexPath && isEndTimeDatePickerVisible == false {
            isStartTimeDatePickerVisible.toggle()
        } else if indexPath == endTimeDateLabelCellIndexPath && isStartTimeDatePickerVisible == false {
            isEndTimeDatePickerVisible.toggle()
        } else if indexPath == startTimeDateLabelCellIndexPath || indexPath == endTimeDateLabelCellIndexPath {
            isStartTimeDatePickerVisible.toggle()
            isEndTimeDatePickerVisible.toggle()
        } else {
            return
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func updateViews(){
        endTimeDatePicker.minimumDate = Calendar.current.date(byAdding: .minute, value: 15, to: startTimeDatePicker.date)
        startTimeLabel.text = startTimeDatePicker.date.formatted(date: .omitted, time: .shortened)
        endTimeLabel.text = endTimeDatePicker.date.formatted(date: .omitted, time: .shortened)
    }
    
    func formattedDays(_ days: Set<Int>)->String{
        updateSaveButtonState()
        if days.isEmpty {
            return "Not Set"
        }
        var orderedDays: [Int] = Array(days)
        orderedDays.sort()

        var fDays: String = ""
        for day in orderedDays {
            switch day {
            case 0:
                fDays += "Mon."
            case 1:
                fDays += "Tue."
            case 2:
                fDays += "Wed."
            case 3:
                fDays += "Th."
            case 4:
                fDays += "Fri."
            case 5:
                fDays += "Sat."
            case 6:
                fDays += "Sun."
            default:
                fDays += " "
            }
            fDays += " "
        }
        return fDays
    }
    
    func selectDaysTableViewController(_ controller: SelectDaysTableViewController, didSelect days: Set<Int>) {
        self.days = days
        daysLabel.text = formattedDays(days)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateViews()
    }
    
    @IBSegueAction func selectDays(_ coder: NSCoder) -> SelectDaysTableViewController? {
        let selectDaysController = SelectDaysTableViewController(coder: coder)
        selectDaysController?.delegate = self
        selectDaysController?.days = days
        return selectDaysController
    }
        
    func updateSaveButtonState() {
        let groupIDText = groupIDTextField.text ?? ""
        
        saveButton.isEnabled = !groupIDText.isEmpty && !days.isEmpty
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField){
        updateSaveButtonState()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveUnwind" else {return}
        let groupID = groupIDTextField.text!
        let profesorName = professorTextField.text ?? ""
        let slotsString = slotsTextField.text ?? "0"
        let slots = Int(slotsString)
        let days = days
        let startTime = startTimeDatePicker.date
        let endTime = endTimeDatePicker.date

        group = Group(groupID: groupID, profesorName: profesorName, slots: slots ?? 0, days: days, startTime: startTime, endTime: endTime, subjectName: subjectName ?? "")
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
