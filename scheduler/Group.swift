import Foundation

class Group: Codable{
    var groupID:String
    var profesorName:String
    var slots:Int //Number of students allowed in that group
    var activeHours:[ActiveTime] = []
    init(groupID: String, profesorName: String = "Juanito Banana", slots: Int = 69){
        self.groupID = groupID
        self.profesorName = profesorName
        self.slots = slots
    }
    
    
    func dateToActiveTime(day: Int, starTime: Date, endTime: Date){
        <#function body#>
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
