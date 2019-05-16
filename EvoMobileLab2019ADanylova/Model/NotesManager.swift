//
//  NotesManager.swift
//  EvoMobileLab2019ADanylova
//
//  Created by Ganna DANYLOVA on 5/15/19.
//  Copyright © 2019 Ganna DANYLOVA. All rights reserved.
//

import Foundation
import CoreData

class NotesManager {
    
    var index = 0
    var managedObjectContext: NSManagedObjectContext?
    var limit = 20
    
    func newNote() -> Notes {
        return NSEntityDescription.insertNewObject(forEntityName: "Notes", into: self.managedObjectContext!) as! Notes
    }
    
   func getAllNotes() -> [Notes] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        fetchRequest.fetchLimit = limit
        fetchRequest.fetchOffset = index
        do {
            let result = try managedObjectContext?.fetch(fetchRequest) as! [Notes]
            return result
        }catch{
            return []
        }
    }
    
    func removeNote(notes : Notes) {
        managedObjectContext?.delete(notes)
    }
    
    func saveNote() {
        print("hello save")
        if (managedObjectContext?.hasChanges)! {
            do {
                try managedObjectContext?.save()
            }
            catch{
                fatalError("Failure to save \(error)");
            }
        }
    }
    func countNotes() -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        print("\nhello count\n")
        return try! managedObjectContext?.count(for: fetchRequest) ?? 0
    }
    
}
