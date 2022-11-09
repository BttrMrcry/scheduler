import UIKit

protocol SelectDaysTableViewControllerDelegate: AnyObject {
    func selectDaysTableViewController(_ controller: SelectDaysTableViewController, didSelect days: Set<Int>)
}

class SelectDaysTableViewController: UITableViewController {
    weak var delegate: SelectDaysTableViewControllerDelegate?
    
    var days: Set<Int>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateCells()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if days!.contains(indexPath.row){
            days!.remove(indexPath.row)
        } else {
            days!.insert(indexPath.row)
        }
        updateCells()
        delegate?.selectDaysTableViewController(self, didSelect: days!)
    }
    
    func updateCells(){
        guard let days = days else {return}
        for day in 0...6 {
            let cell = tableView.cellForRow(at: IndexPath(row: day, section: 0))
            if(days.contains(day)){
                cell!.accessoryType = .checkmark
            } else {
                cell!.accessoryType = .none
            }
        }
    }
}
