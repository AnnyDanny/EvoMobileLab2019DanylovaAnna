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
            print("\n\n\neditNote != nil\n")
            print("editNote: \(editNote)")
            print("\n\n\n")
            editTextView.text = editNote?.descriptionNote
        }
        else {
            print("\nnote == nil\n")
        }
    }

    @objc func back(){
        print("\n\nclicked back\n\n")
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
