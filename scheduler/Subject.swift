//
//  Group.swift
//  scheduler
//
//  Created by Ricardo López  on 13/08/22.
//

import Foundation

struct Subject{
    let name:String
    var Groups:[Group]
    init(name:String){
        self.name = name
        Groups = [Group(number: 1), Group(number: 2), Group(number: 3), Group(number: 4)]
    }
}
