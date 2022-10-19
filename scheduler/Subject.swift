import Foundation

struct Subject: Codable {
    let name:String
    var groups:[Group]
    init(name:String){
        self.name = name
        groups = [Group(groupID: "A"), Group(groupID: "B"), Group(groupID: "C"), Group(groupID: "D")]
    }
}
