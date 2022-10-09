//
//  Group.swift
//  scheduler
//
//  Created by Ricardo López  on 14/08/22.
//

import Foundation

class Group: Codable{
    let groupID:String
    let profesorName:String?
    let room:Int? //Number of students allowed in that group
    var activeHours:[ActiveTime] = []
    //TO DO: Change this constructure and atributes to be not optionals
    init(groupID: String){
        self.groupID = groupID
        self.profesorName = nil
        self.room = nil
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
