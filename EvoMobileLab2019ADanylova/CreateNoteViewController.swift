//
//  CreateNoteViewController.swift
//  EvoMobileLab2019ADanylova
//
//  Created by Ganna DANYLOVA on 5/14/19.
//  Copyright © 2019 Ganna DANYLOVA. All rights reserved.
//

import UIKit

class CreateNoteViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    var createNotes: DefaultNotes?
    
    @IBOutlet weak var createDescNote: UITextView!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
//        navigationController!.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDescNote.layer.borderWidth = 4
        createDescNote.delegate = self
        createDescNote.delegate = self
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
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if sender as AnyObject? === doneButton {
            if let desc = createDescNote.text, !desc.isEmpty {
                createNotes = DefaultNotes(date: .distantFuture, description: createDescNote.text)
            }
        }
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
