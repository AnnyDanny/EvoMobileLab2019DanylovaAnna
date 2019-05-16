//
//  CreateNoteViewController.swift
//  EvoMobileLab2019ADanylova
//
//  Created by Ganna DANYLOVA on 5/14/19.
//  Copyright © 2019 Ganna DANYLOVA. All rights reserved.
//

import UIKit

class CreateNoteViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var createDescNote: UITextView!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDescNote.delegate = self
        createDescNote.delegate = self
        addTextViewHeight(createDescNote : createDescNote)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        if let desc = createDescNote.text, !desc.isEmpty {
            let note = notesManager.newNote()
            note.descriptionNote = createDescNote.text
            note.creationDate = Date() as Date
            notesManager.saveNote()
        }
        dismiss(animated: true, completion: nil)
    }
    
    func addTextViewHeight(createDescNote : UITextView)
    {
        var frame = self.createDescNote.frame
        frame.size.height = self.createDescNote.contentSize.height
        self.createDescNote.frame = frame
    }
}
