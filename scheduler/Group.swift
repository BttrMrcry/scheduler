import Foundation

class Group: Codable{
    let groupID:String
    let profesorName:String
    let room:Int //Number of students allowed in that group
    var activeHours:[ActiveTime] = []
    init(groupID: String, profesorName: String = "Juanito Banana", room: Int = 69){
        self.groupID = groupID
        self.profesorName = profesorName
        self.room = room
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
