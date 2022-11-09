import Foundation


struct ActiveTime: Codable {
    var minuteStart:Int
    var duration:Int
}

/*
Conforms to the comparable protocol so ActiveTime can be use in the AVL tree.

Two ActiveTime structures are equal if they overlap in any moment
One ActiveTIme structure is less than other if its endtime is less than
the startTime of the second one.
*/

extension ActiveTime: Comparable {
    static func < (lhs: ActiveTime, rhs: ActiveTime) -> Bool {
        if (lhs.minuteStart + lhs.duration) <= rhs.minuteStart {
            return true
        }else{
            return false
        }
    }
    
    static func == (lhs: ActiveTime, rhs: ActiveTime) -> Bool {
        if lhs.minuteStart == rhs.minuteStart {
            return true
        }
        
        if lhs.minuteStart > rhs.minuteStart && lhs.minuteStart < rhs.minuteStart + rhs.duration {
            return true
        }
        
        if rhs.minuteStart > lhs.minuteStart && rhs.minuteStart < lhs.minuteStart + lhs.duration {
            return true
        }
        return false
    }
}
