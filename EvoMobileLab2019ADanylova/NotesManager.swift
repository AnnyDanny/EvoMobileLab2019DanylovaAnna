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
    
    var managedObjectContext: NSManagedObjectContext?
    
//    init() {
//        let context : NSManagedObjectContext
//        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
//        let myBundle = Bundle(identifier: "org.cocoapods.vlikhotk2019")
//        guard let modelURL = myBundle?.url(forResource: "article", withExtension: "momd") else {
//            fatalError("Error loading model from bundle")
//        }
    func newNote() -> Notes {
//        return Notes(entity: Notes.entity(), insertInto: managedObjectContext)
        return NSEntityDescription.insertNewObject(forEntityName: "Notes", into: self.managedObjectContext!) as! Notes
    }
    
   func getAllArticles() -> [Notes] {
    print("hello getAllArticles")
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Notes")
        do {
            print("hello fetchRequest")
            let result = try managedObjectContext?.fetch(fetchRequest) as! [Notes]
            return result
        }catch{
            return []
        }
    }
    
    func removeArticle(article : Notes) {
        managedObjectContext?.delete(article)
    }
    
    func save() {
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
    
}
