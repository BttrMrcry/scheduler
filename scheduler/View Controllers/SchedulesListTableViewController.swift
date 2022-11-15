//
//  SchedulesListTableViewController.swift
//  scheduler
//
//  Created by rl on 08/11/22.
//

import UIKit

class SchedulesListTableViewController: UITableViewController {
    let schedules: [[Group]]?
    var openSection:[Bool]?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    init?(coder: NSCoder, schedules:[Set<Group>]) {
        var arraySchedules:[[Group]] = []
        for schedule in schedules {
            arraySchedules.append(Array(schedule))
        }
        self.schedules = arraySchedules
        openSection = Array(repeating: false, count: schedules.count)
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        self.schedules = nil
        openSection = nil
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        if indexPath.row == 0 {
            content.text = "Option " + String(indexPath.section + 1)
        }else{
            let currGroup = schedules[indexPath.section][indexPath.row - 1]
            content.text = currGroup.subjectName + ": group " + currGroup.groupID
            let startHour = currGroup.getStartTime().formatted(date: .omitted, time: .shortened)
            let endHour = currGroup.getEndTime().formatted(date: .omitted, time: .shortened)
            let formatedDays = formattedDays(currGroup.getDays())
            content.secondaryText = formatedDays + " " + startHour + "-" + endHour
        }
        
        
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
        openSection![indexPath.section] = !openSection![indexPath.section]
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

}
