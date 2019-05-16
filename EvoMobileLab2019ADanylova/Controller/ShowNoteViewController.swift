//
//  ShowNoteViewController.swift
//  EvoMobileLab2019ADanylova
//
//  Created by Ganna DANYLOVA on 5/14/19.
//  Copyright © 2019 Ganna DANYLOVA. All rights reserved.
//

import UIKit

class ShowNoteViewController: UIViewController {

    var note: Notes?
    @IBOutlet weak var showNote: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if note != nil {
            showNote.text = note?.descriptionNote
        }
        else {
            print("\nnote == nil\n")
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareData))
    }

    @objc func shareData() {
        print("shared pressed")
        let activityViewController = UIActivityViewController(activityItems: ["check"], applicationActivities: nil)
        present(activityViewController, animated: true)
    }
}
