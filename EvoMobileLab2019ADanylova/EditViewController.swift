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
    
//    @IBAction func save(_ sender: UIBarButtonItem) {
//        //        navigationController!.popViewController(animated: true)
//        dismiss(animated: true, completion: nil)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if editNote != nil {
            print("\n\n\neditNote != nil\n")
            print("editNote: \(editNote)")
            print("\n\n\n")
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
            notesManager.save()
        self.navigationController?.popViewController(animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
