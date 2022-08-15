//
//  Group.swift
//  scheduler
//
//  Created by Ricardo López  on 14/08/22.
//

import Foundation

struct Group {
    let number:Int
    let profesorName:String?
    let room:Int? //Number of students allowed in that group
    
    init(number:Int){
        self.number = number
        self.profesorName = nil
        self.room = nil
    }
}
