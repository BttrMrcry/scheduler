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
    
    //var days? = [0:false,1:false,2:false,3:false,4:false,5:false,6:false]
    var days: [Int:Bool]?
    var group: Group?
    
    init?(coder: NSCoder, group: Group?) {
        self.group = group
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        self.group = nil
        super.init(coder: coder)
    }
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimeDatePicker.minimumDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: Date())
        startTimeDatePicker.maximumDate = Calendar.current.date(bySettingHour: 23, minute: 30, second: 0, of: Date())
        endTimeDatePicker.maximumDate = Calendar.current.date(bySettingHour: 23, minute: 45, second: 0, of: Date())
        updateViews()
        updateDays()
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
        endTimeLabel .text = endTimeDatePicker.date.formatted(date: .omitted, time: .shortened)
    }
    
    func updateDays(){
        if let days = days {
            daysLabel.text = formattedDays(days)
        } else {
            daysLabel.text = "Not Set"
        }
    }
    
    func formattedDays(_ selectedDays: [Int:Bool])->String{
        var fdays = ""
        
        for day in selectedDays {
            switch day.key {
            case 0:
                if day.value {
                    fdays += "Mon."
                }
            case 1:
                if day.value {
                    fdays += "Tue."
                }
            case 2:
                if day.value {
                    fdays += "Wed."
                }
            case 3:
                if day.value {
                    fdays += "Thur."
                }
            case 4:
                if day.value {
                    fdays += "Fri."
                }
            case 5:
                if day.value {
                    fdays += "Sat."
                }
            case 6:
                if day.value {
                    fdays += "Sun"
                }
            default:
                return ""
            }
            
            fdays += " "
        }
        return fdays
    }
    
    func selectDaysTableViewController(_ controller: SelectDaysTableViewController, didSelect days: [Int : Bool]) {
        self.days = days
        updateDays()
    }
    
    @IBAction func doneBarButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateViews()
    }
    
    @IBSegueAction func selectDays(_ coder: NSCoder) -> SelectDaysTableViewController? {
        
        let selectDaysController = SelectDaysTableViewController(coder: coder)
        selectDaysController?.delegate = self
        selectDaysController?.days = days ?? [0:false,1:false,2:false,3:false,4:false,5:false,6:false]
        return selectDaysController
    }
    
    func 
    
    
}
