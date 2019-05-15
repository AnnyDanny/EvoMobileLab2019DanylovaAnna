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
        
//        let share = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: self, action: #selector(shareData))
//        self.navigationItem.rightBarButtonItem = share
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareData))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
    }

//    @objc func shareData(){
//
//        if let image = UIImage(named: "myImage") {
//            let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
//            dismiss(animated: true, completion: nil)
//        }

    @objc func shareData() {
        print("shared pressed")
        //        guard let detailBeer = detailBeer,
        //            let url = detailBeer.exportToFileURL() else {
        //                return
        //        }
        
        let activityViewController = UIActivityViewController(activityItems: ["check"], applicationActivities: nil)
        present(activityViewController, animated: true)
        
//        let activityViewController = UIActivityViewController(
//            activityItems: ["Check out this beer I liked using Beer Tracker.", note],
//            applicationActivities: nil)
//        if let popoverPresentationController = activityViewController.popoverPresentationController {
//            popoverPresentationController.barButtonItem = (sender as! UIBarButtonItem)
//        }
//        present(activityViewController, animated: true, completion: nil)
    }
    
}


//    if let edit = editTextView.text, !edit.isEmpty {
//        //            let note = Notes(entity: Notes.entity(), insertInto: notesManager.managedObjectContext)
//        //            let note = notesManager?.newNote()
//        editNote?.descriptionNote = editTextView.text
//        editNote?.creationDate = Date() as NSDate
//        notesManager.save()
//        //try? notesManager.managedObjectContext?.save()
//        print("\nnote:\(editNote?.descriptionNote)\n")
//    }
//    //        dismiss(animated: true, completion: nil)
//    self.navigationController?.popViewController(animated: false)
//    print("\n\nclicked save\n\n")
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


