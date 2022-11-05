import UIKit

protocol SelectDaysTableViewControllerDelegate: AnyObject {
    func selectDaysTableViewController(_ controller: SelectDaysTableViewController, didSelect days: [Int:Bool])
}

class SelectDaysTableViewController: UITableViewController {
    weak var delegate: SelectDaysTableViewControllerDelegate?
    
    var days = [0:false,1:false,2:false,3:false,4:false,5:false,6:false]
    //var days: [Int:Bool]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        days[indexPath.row]?.toggle()
        updateCells()
        delegate?.selectDaysTableViewController(self, didSelect: days)
    }
    
    func updateCells(){
        for day in days {
            let cell = tableView.cellForRow(at: IndexPath(row: day.key, section: 0))
            if(day.value){
                cell!.accessoryType = .checkmark
            } else {
                cell!.accessoryType = .none
            }
        }
    }
}
