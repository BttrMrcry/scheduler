//
//  Group.swift
//  scheduler
//
//  Created by Ricardo López  on 13/08/22.
//

import Foundation

struct Subject: Codable {
    let name:String
    var Groups:[Group]
    init(name:String){
        self.name = name
        Groups = [Group(groupID: "A"), Group(groupID: "B"), Group(groupID: "C"), Group(groupID: "D")]
    }
}
