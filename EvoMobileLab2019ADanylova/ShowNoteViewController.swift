//
//  ShowNoteViewController.swift
//  EvoMobileLab2019ADanylova
//
//  Created by Ganna DANYLOVA on 5/14/19.
//  Copyright © 2019 Ganna DANYLOVA. All rights reserved.
//

import UIKit

class ShowNoteViewController: UIViewController {

    
    @IBOutlet weak var showNote: UILabel!
    
    var note: Notes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if note != nil {
            showNote.text = note?.descriptionNote
        }
        else {
            print("\nnote == nil\n")
        }
        // Do any additional setup after loading the view.
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
