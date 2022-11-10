//
//  SchedulesListTableViewController.swift
//  scheduler
//
//  Created by rl on 08/11/22.
//

import UIKit

class SchedulesListTableViewController: UITableViewController {
    let schedules: [Set<Group>]?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    init?(coder: NSCoder, schedules:[Set<Group>]) {
        self.schedules = schedules
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        self.schedules = nil
        super.init(coder: coder)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return schedules?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "Option: " + String(indexPath.row)
        cell.contentConfiguration = content
        return cell
    }


    @IBSegueAction func showSelectedSchedule(_ coder: NSCoder, sender: Any?) -> CallendarViewController? {
        let sender = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: sender)
        let schedules = schedules!
        let selectedSchedule = schedules[indexPath!.row]
        return CallendarViewController(coder: coder, schedule: selectedSchedule)
    }
    

}
