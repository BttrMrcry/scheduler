//
//  ViewController.swift
//  scheduler
//
//  Created by rl on 04/08/22.
//

import UIKit

class MakerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    // Return the number of rows for the table.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 20
    }

    // Provide a cell object for each row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // Fetch a cell of the appropriate type.
       let cell = tableView.dequeueReusableCell(withIdentifier: "makerCell", for: indexPath)
       
       // Configure the cell’s contents.
       cell.textLabel!.text = "Cell text"
           
       return cell
    }
    
    

}

