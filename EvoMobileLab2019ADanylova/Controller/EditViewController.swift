//
//  EditViewController.swift
//  EvoMobileLab2019ADanylova
//
//  Created by Ganna DANYLOVA on 5/15/19.
//  Copyright © 2019 Ganna DANYLOVA. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var editTextView: UITextView!
    
    @IBAction func editItem(_ sender: UIBarButtonItem) {
        
    }
    
     var editNote: Notes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if editNote != nil {
            editTextView.text = editNote?.descriptionNote
        }
        else {
            print("\nnote == nil\n")
        }
        
        let saveButton = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.plain, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItem = saveButton
    }

    @objc func save(){
        editNote?.descriptionNote = editTextView.text
        editNote?.creationDate = Date()
            notesManager.saveNote()
        self.navigationController?.popViewController(animated: false)
    }

}
