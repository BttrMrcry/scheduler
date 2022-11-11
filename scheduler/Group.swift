import Foundation

class Group: Codable{
    var groupID: String
    var profesorName: String
    var slots: Int //Number of students allowed in that group
    var subjectName: String
    private var days: Set<Int>
    private var startTime: Date
    private var endTime: Date
    private var activeHours:[ActiveTime]
    
    init(groupID: String, profesorName: String = "Juanito Banana", slots: Int = 69, days: Set<Int>, startTime: Date, endTime: Date, subjectName: String){
        self.groupID = groupID
        self.profesorName = profesorName
        self.slots = slots
        self.days = days
        self.startTime = startTime
        self.endTime = endTime
        self.subjectName = subjectName
        self.activeHours = Group.setActiveHoours(days,startTime,endTime)
    }
    
    static func setActiveHoours(_ days: Set<Int>,_ startTime: Date,_ endTime: Date)->[ActiveTime]{
        var activeHours:[ActiveTime] = []
        let hourStart = Calendar.current.component(.hour, from: startTime)
        let hourEnd = Calendar.current.component(.hour, from: endTime)
        let minuteStart = Calendar.current.component(.minute, from: startTime)
        let minuteEnd = Calendar.current.component(.minute, from: endTime)
        
        for day in days {
            let start = ((hourStart*60)+minuteStart)+(day*1440)
            let end = ((hourEnd*60)+minuteEnd)+(day*1440)
            activeHours.append(ActiveTime(minuteStart: start, duration: end-start))
        }
        return activeHours
    }
    
    func setStartTime(_ startTime: Date){
        self.startTime = startTime
    }
    
    func getStartTime()->Date{
        return self.startTime
    }
    
    func setEndTime(_ endTime: Date){
        self.startTime = endTime
    }
    
    func getEndTime()->Date{
        return self.endTime
    }
    
    func setDays(days: Set<Int>){
        self.days = days
    }
    
    func getDays()->Set<Int>{
        return self.days
    }
    
    func getActiveHours()->[ActiveTime]{
        return self.activeHours
    }
}

/*
 Conforms with Equatable protocol using object identifier
*/
extension Group: Equatable {
    static func == (lhs: Group, rhs: Group) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
}

/*
 Conforms with Hashable protocol using object indentifier
*/
extension Group: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
