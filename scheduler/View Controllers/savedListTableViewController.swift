//
//  SchedulesListTableViewController.swift
//  scheduler
//
//  Created by rl on 08/11/22.
//

import UIKit

class savedListTableViewController: UITableViewController {
    var openSection:[Bool]!
    var schedules:[[Group]]!
    var schedulesController:SchedulesController!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.schedulesController = SchedulesController()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        schedulesController.loadSchedules()
        var arraySchedules:[[Group]] = []
        for schedule in schedulesController.savedSchedules {
            var arraySchedule = Array(schedule)
            arraySchedule.sort(by: {$0.subjectName < $1.subjectName})
            arraySchedules.append(arraySchedule)
        }
        self.schedules = arraySchedules
        self.openSection = Array(repeating: false, count: schedules.count)
        tableView.reloadData()
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
        if openSection[section] {
            return schedules[section].count + 1
        }else{
            return 1
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "savedHeaderCell", for: indexPath) as! ScheduleTableViewCell
            cell.cellButtonDelegate = self
            cell.label.text = generateOptionName(Schedule: schedules[indexPath.section])
            cell.saveButton.setTitle("Delete", for: .normal)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "savedScheduleCell", for: indexPath)
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


extension savedListTableViewController: ScheduleTableViewCellDelegate {
    func didTapCellButton(sender: UITableViewCell) {
        let indexPath = tableView.indexPath(for: sender)
        guard let indexPath = indexPath else {
            return
        }
        schedules.remove(at: indexPath.section)
        schedulesController.savedSchedules.remove(at: indexPath.section)
        schedulesController.saveSchedules()
    
        tableView.reloadData()
    }
}
