//
//  SchedulesController.swift
//  scheduler
//
//  Created by rl on 08/11/22.
//

import Foundation

class SchedulesController {
    var currentSchedules: [Set<Group>] = []
    var savedSchedules: [Set<Group>] = []
    
    func loadSchedules(){
        let propertyListDecoder = PropertyListDecoder()
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("schedules").appendingPathExtension("plist")
        print(fileURL)
        guard let retrivedSubjects = try? Data(contentsOf: fileURL) else {
            print("Los horarios no se pudieron cargar")
            return
        }
        
        guard let decodedSchedules  = try? propertyListDecoder.decode([Set<Group>].self, from: retrivedSubjects) else{
            print("Los horarios cargaron, pero no son válidos")
            savedSchedules = [Set<Group>]()
            saveSchedules()
            return
        }
        savedSchedules = decodedSchedules 
        print("Horarios cargados exitosamente")
    }
    func saveSchedules(){
        let propertyListEncoder = PropertyListEncoder()
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("schedules").appendingPathExtension("plist")
        guard let encodedSubjects = try? propertyListEncoder.encode(self.savedSchedules)else{
            print("Error al guardar los horarios")
            return
        }
        
        try? encodedSubjects.write(to: fileURL, options: .noFileProtection)
        print("Horarios guardados exitosamente")
    }
}
