//
//  CreateNoteViewController.swift
//  EvoMobileLab2019ADanylova
//
//  Created by Ganna DANYLOVA on 5/14/19.
//  Copyright © 2019 Ganna DANYLOVA. All rights reserved.
//

import UIKit

class CreateNoteViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

//    var createNotes: Notes?
    
//    var notesManager : NotesManager?
    
    @IBOutlet weak var createDescNote: UITextView!
    
//    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
//        navigationController!.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDescNote.layer.borderWidth = 4
        createDescNote.delegate = self
        createDescNote.delegate = self
        if notesManager == nil {
//            print("NIIIIIIIIL")
        }
        addTextViewHeight(createDescNote : createDescNote)
        // Do any additional setup after loading the view.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        if let desc = createDescNote.text, !desc.isEmpty {
            let note = Notes(entity: Notes.entity(), insertInto: notesManager.managedObjectContext)
//            let note = notesManager?.newNote()
            note.descriptionNote = createDescNote.text
            note.creationDate = Date() as Date
            notesManager.save()
            //try? notesManager.managedObjectContext?.save()
            print("\nnote:\(note.descriptionNote)\n")
        }
        dismiss(animated: true, completion: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//        if sender as AnyObject? === doneButton {
//            if let desc = createDescNote.text, !desc.isEmpty {
////                let note = Notes(entity: Notes.entity(), insertInto: notesManager.managedObjectContext)
//                let note = notesManager?.newNote()
//                note?.descriptionNote = createDescNote.text
//                note?.creationDate = Date() as NSDate
//                notesManager?.save()
//                print("\nnote:\(note?.descriptionNote)\n")
//            }
//        }
//    }
    
    func addTextViewHeight(createDescNote : UITextView)
    {
        var frame = self.createDescNote.frame
        frame.size.height = self.createDescNote.contentSize.height
        self.createDescNote.frame = frame
//        createDescNote.translatesAutoresizingMaskIntoConstraints = true
//        createDescNote.sizeToFit()
//        createDescNote.isScrollEnabled = false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
