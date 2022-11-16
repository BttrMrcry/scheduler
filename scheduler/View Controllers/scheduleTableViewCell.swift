//
//  scheduleTableViewCell.swift
//  scheduler
//
//  Created by rl on 11/11/22.
//

import UIKit

protocol ScheduleTableViewCellDelegate {
    func didTapCellButton(sender: UITableViewCell)
}

class ScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var label: UILabel!
        
    var cellButtonDelegate: ScheduleTableViewCellDelegate?
   
    override func awakeFromNib() {
        super.awakeFromNib()
        saveButton.setTitle("Save", for: .disabled)
        saveButton.setTitle("Save", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func buttonTapped() {
        guard let cellButtonDelegate = cellButtonDelegate else {
            return
        }
        cellButtonDelegate.didTapCellButton(sender: self)
    }
}
/**
 
 */
