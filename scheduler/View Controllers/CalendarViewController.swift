//
//  CallendarViewController.swift
//  scheduler
//
//  Created by rl on 09/11/22.
//

import UIKit
import ECWeekView
import SwiftDate

class CalendarViewController: UIViewController {

    @IBOutlet private var weekView: ECWeekView!
    let schedule:Set<Group>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        weekView.dataSource = self
    }
    
    init?(coder: NSCoder, schedule: Set<Group>) {
        self.schedule = schedule
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        self.schedule = nil
        super.init(coder: coder)
    }
    

}

extension CalendarViewController: ECWeekViewDataSource {
   
    
    func weekViewGenerateEvents(_ weekView: ECWeekView, date: DateInRegion, eventCompletion: @escaping ([ECWeekViewEvent]?) -> Void) -> [ECWeekViewEvent]? {
//        let start1 = date.dateBySet(hour: (date.day % 5) + 9, min: 0, secs: 0)!
//        let end1 = date.dateBySet(hour: start1.hour + (date.day % 3) + 1, min: 30 * (date.day % 2), secs: 0)!
//        let event = ECWeekViewEvent(title: "Title \(date.day)", subtitle: "Subtitle \(date.day)", start: start1, end: end1)

//        let lunchStart = date.dateBySet(hour: 12, min: 0, secs: 0)!
//        let lunchEnd = date.dateBySet(hour: 13, min: 0, secs: 0)!
//        let lunch = ECWeekViewEvent(title: "Lunch", subtitle: "lunch", start: lunchStart, end: lunchEnd)
        guard let schedule = schedule else {
                return nil
        }
        
        
        for group in schedule {
            for activeHour in group.activeHours {
                
            }
        }
        
        
        
        DispatchQueue.global(qos: .background).async {
            eventCompletion([])
        }
        
        return nil
    }
    
    
}
