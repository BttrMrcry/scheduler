//
//  SubjectController.swift
//  scheduler
//
//  Created by rl on 18/08/22.
//

import Foundation

class SubjectsController {
    var subjects:[Subject] = []
    
    func loadSubjects(){
        let propertyListDecoder = PropertyListDecoder()
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("subject").appendingPathExtension("plist")
        print(fileURL)
        guard let retrivedSubjects = try? Data(contentsOf: fileURL) else {
            print("Los datos no se pudieron cargar")
            subjects = [Subject(name: "Calculus"), Subject(name:"EDA"), Subject(name:"POO"), Subject(name: "Circuits"), Subject(name:"AI")]
            return
        }
        
        guard let decodedSubjects = try? propertyListDecoder.decode([Subject].self, from: retrivedSubjects) else{
            print("Los datos cargaron pero no son válidos")
            subjects = [Subject]()
            saveSubjects()
            return
        }
        subjects = decodedSubjects
        print("Datos cargados exitosamente")
    }
    func saveSubjects(){
        let propertyListEncoder = PropertyListEncoder()
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("subject").appendingPathExtension("plist")
        
        guard let encodedSubjects = try? propertyListEncoder.encode(self.subjects)else{
            print("Error al guardar los datos")
            return
        }
        
        try? encodedSubjects.write(to: fileURL, options: .noFileProtection)
        print("Datos guardados exitosamente")
    }
}
