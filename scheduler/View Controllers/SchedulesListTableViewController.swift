//
//  SchedulesListTableViewController.swift
//  scheduler
//
//  Created by rl on 08/11/22.
//

import UIKit

class SchedulesListTableViewController: UITableViewController {
    var openSection:[Bool]?
    var savedSchedules:[Bool]?
    var schedules:[[Group]]?
    var schedulesController:SchedulesController?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    init?(coder: NSCoder, schedulesController: SchedulesController) {
        var arraySchedules:[[Group]] = []
        for schedule in schedulesController.currentSchedules {
            var arraySchedule = Array(schedule)
            arraySchedule.sort(by: {$0.subjectName < $1.subjectName})
            arraySchedules.append(arraySchedule)
        }
        self.schedules = arraySchedules
        self.schedulesController = schedulesController
        openSection = Array(repeating: false, count: schedulesController.currentSchedules.count)
        savedSchedules = Array(repeating: false, count: schedulesController.currentSchedules.count)
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        self.openSection = nil
        self.savedSchedules = nil
        self.schedulesController = nil
        super.init(coder: coder)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if let schedules = schedules {
            return schedules.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let openSection = openSection else {
            return 0
        }
        guard let schedules = schedules else {
            return 0
        }
        
        if openSection[section] {
            return schedules[section].count + 1
        }else{
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let schedules = schedules else {
            return UITableViewCell()
        }
        
        guard let savedSchedules = savedSchedules else {
            return UITableViewCell()
        }
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! ScheduleTableViewCell
            cell.cellButtonDelegate = self
            cell.label.text = generateOptionName(Schedule: schedules[indexPath.section])
            
            if savedSchedules[indexPath.section] {
                cell.saveButton.isEnabled = false
                
            }else {
                cell.saveButton.isEnabled = true
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath)
            var content = cell.defaultContentConfiguration()
            let currGroup = schedules[indexPath.section][indexPath.row - 1]
            content.text = currGroup.subjectName + ": group " + currGroup.groupID
            let startHour = currGroup.getStartTime().formatted(date: .omitted, time: .shortened)
            let endHour = currGroup.getEndTime().formatted(date: .omitted, time: .shortened)
            let formatedDays = formattedDays(currGroup.getDays())
            content.secondaryText = formatedDays + " " + startHour + "-" + endHour
            cell.contentConfiguration = content
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            openSection![indexPath.section] = !openSection![indexPath.section]
        }
        
        tableView.reloadSections([indexPath.section], with: .none)
    }

    func formattedDays(_ days: Set<Int>)->String{
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
    func generateOptionName(Schedule: [Group]) -> String {
        var res = ""
        for group in Schedule {
            res += group.groupID + " "
        }
        return res
    }
}

extension SchedulesListTableViewController: ScheduleTableViewCellDelegate {
    func didTapCellButton(sender: UITableViewCell) {
        let indexPath = tableView.indexPath(for: sender)
    
        guard let indexPath = indexPath else {
            return
        }
        schedulesController?.loadSchedules()
        var loadedSchedules = schedulesController?.savedSchedules ?? []
        let curSchedule = schedules?[indexPath.section]
        if let curSchedule = curSchedule {
            loadedSchedules.append(Set(curSchedule))
            schedulesController?.savedSchedules = loadedSchedules
            schedulesController?.saveSchedules()
            
        }
        
        savedSchedules?[indexPath.section] = true
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    
}
