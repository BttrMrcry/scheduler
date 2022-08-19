//
//  SubjectController.swift
//  scheduler
//
//  Created by rl on 18/08/22.
//

import Foundation

class SubjectsController{
    var subjects:[Subject]
    
    init(){
        subjects = [Subject(name: "Calculus"), Subject(name:"EDA"), Subject(name:"POO"), Subject(name: "Circuits"), Subject(name:"AI")]
    }
    
    private func loadSubjects(){
        let propertyListDecoder = PropertyListDecoder()
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("subject").appendingPathComponent("plist")
        guard let retrivedSubjects = try? Data(contentsOf: fileURL) else {
            subjects = [Subject]()
            saveSubjects()
            return
        }
        
        guard let decodedSubjects = try? propertyListDecoder.decode([Subject].self, from: retrivedSubjects) else{
            subjects = [Subject]()
            saveSubjects()
            return
        }
        
        subjects = decodedSubjects
        
        
    }
        func saveSubjects(){
        let propertyListEncoder = PropertyListEncoder()
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("subject").appendingPathComponent("plist")
        
        guard let encodedSubjects = try? propertyListEncoder.encode(self.subjects)else{
            return
        }
        
        try? encodedSubjects.write(to: fileURL, options: .noFileProtection)
        
    }
}
