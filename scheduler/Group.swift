//
//  Group.swift
//  scheduler
//
//  Created by Ricardo López  on 14/08/22.
//

import Foundation

struct Group: Codable {
    let number:Int
    let profesorName:String?
    let room:Int? //Number of students allowed in that group
    let days:[Day]?
    init(number:Int){
        self.number = number
        self.profesorName = nil
        self.room = nil
        self.days = nil
    }
}
