import UIKit

class InformationTableViewController: UITableViewController {
    
    
    @IBOutlet weak var q1Label: UITableViewCell!
    @IBOutlet weak var q2Label: UITableViewCell!
    @IBOutlet weak var q3Label: UITableViewCell!
    @IBOutlet weak var q4Label: UILabel!
    @IBOutlet weak var q5Label: UITableViewCell!
    @IBOutlet weak var q6Label: UITableViewCell!
    @IBOutlet weak var q7Label: UITableViewCell!
    
    @IBOutlet weak var q1Ans: UITableViewCell!
    @IBOutlet weak var q2Ans: UITableViewCell!
    @IBOutlet weak var q3Ans: UITableViewCell!
    @IBOutlet weak var q4Ans: UITableViewCell!
    @IBOutlet weak var q5Ans: UITableViewCell!
    @IBOutlet weak var q6Ans: UITableViewCell!
    @IBOutlet weak var q7Ans: UITableViewCell!
    
    let q1CellIndexPath = IndexPath(row: 1, section: 0)
    let q2CellIndexPath = IndexPath(row: 1, section: 1)
    let q3CellIndexPath = IndexPath(row: 1, section: 2)
    let q4CellIndexPath = IndexPath(row: 1, section: 3)
    let q5CellIndexPath = IndexPath(row: 1, section: 4)
    let q6CellIndexPath = IndexPath(row: 1, section: 5)
    let q7CellIndexPath = IndexPath(row: 1, section: 6)
    
    let q1LCellIndexPath = IndexPath(row: 0, section: 0)
    let q2LCellIndexPath = IndexPath(row: 0, section: 1)
    let q3LCellIndexPath = IndexPath(row: 0, section: 2)
    let q4LCellIndexPath = IndexPath(row: 0, section: 3)
    let q5LCellIndexPath = IndexPath(row: 0, section: 4)
    let q6LCellIndexPath = IndexPath(row: 0, section: 5)
    let q7LCellIndexPath = IndexPath(row: 0, section: 6)
    
    var isQ1Visible: Bool = false {
        didSet {
            q1Ans.isHidden = !isQ1Visible
        }
    }
    
    var isQ2Visible: Bool = false {
        didSet {
            q2Ans.isHidden = !isQ2Visible
        }
    }

    var isQ3Visible: Bool = false {
        didSet {
            q3Ans.isHidden = !isQ3Visible
        }
    }

    var isQ4Visible: Bool = false {
        didSet {
            q4Ans.isHidden = !isQ4Visible
        }
    }

    var isQ5Visible: Bool = false {
        didSet {
            q5Ans.isHidden = !isQ5Visible
        }
    }

    var isQ6Visible: Bool = false {
        didSet {
            q6Ans.isHidden = !isQ6Visible
        }
    }

    var isQ7Visible: Bool = false {
        didSet {
            q7Ans.isHidden = !isQ7Visible
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath == q1LCellIndexPath {
            isQ1Visible.toggle()
        } else if indexPath == q2LCellIndexPath {
            isQ2Visible.toggle()
        } else if indexPath == q3LCellIndexPath {
            isQ3Visible.toggle()
        } else if indexPath == q4LCellIndexPath {
            isQ4Visible.toggle()
        } else if indexPath == q5LCellIndexPath {
            isQ5Visible.toggle()
        } else if indexPath == q6LCellIndexPath {
            isQ6Visible.toggle()
        } else if indexPath == q7LCellIndexPath {
            isQ7Visible.toggle()
        } else {
            return
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case q1CellIndexPath where isQ1Visible == false:
            return 0
        case q2CellIndexPath where isQ2Visible == false:
            return 0
        case q3CellIndexPath where isQ3Visible == false:
            return 0
        case q4CellIndexPath where isQ4Visible == false:
            return 0
        case q5CellIndexPath where isQ5Visible == false:
            return 0
        case q6CellIndexPath where isQ6Visible == false:
            return 0
        case q7CellIndexPath where isQ7Visible == false:
            return 0
        default:
            return UITableView.automaticDimension
        }
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case q1CellIndexPath:
            return 190
        case q2CellIndexPath:
            return 190
        case q3CellIndexPath:
            return 190
        case q4CellIndexPath:
            return 190
        case q5CellIndexPath:
            return 190
        case q6CellIndexPath:
            return 190
        case q7CellIndexPath:
            return 190
        default:
            return UITableView.automaticDimension
        }
    }
}
