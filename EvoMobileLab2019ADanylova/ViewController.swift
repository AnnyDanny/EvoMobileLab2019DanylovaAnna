//
//  ViewController.swift
//  EvoMobileLab2019ADanylova
//
//  Created by Ganna DANYLOVA on 5/10/19.
//  Copyright © 2019 Ganna DANYLOVA. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableViewNotes: UITableView!
    
    @IBAction func item(_ sender: UIBarButtonItem) {
        
    }
    
    var data: [DefaultNotes] = []
//    var data: [NSManagedObject] = []
    var note: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewNotes.dataSource = self
        tableViewNotes.delegate = self
        tableViewNotes.estimatedRowHeight = 200
        tableViewNotes.rowHeight = UITableViewAutomaticDimension
//        createDefaultNote()
//        let imageForTitle = "notes"
//        let image = UIImage(named: imageForTitle)
//        image.contentMode = .scaleAspectFit
//        navigationItem.titleView = UIImageView(image: image)
//        navigationItem.rightBarButtonItem = editButtonItem
//        updateEditButtonState()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

//    func createDefaultNote() {
//        let note1 = DefaultNotes(date: Date(), description : "Hello where")
//        let note2 = DefaultNotes(date:  Date(), description: "Hei, whats up?")
//        let note3 = DefaultNotes(date:  Date(), description: "Whats going on?")
//
//        data.append(note1)
//        data.append(note2)
//        data.append(note3)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewNotes.dequeueReusableCell(withIdentifier: "notesCell") as! NotesTableViewCell
        
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = UIColor.purple
        }
        else {
            cell.contentView.backgroundColor = UIColor.lightGray
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        cell.dateLablel.text = dateFormatter.string(from: data[indexPath.row].date)
        cell.descLabel.text = data[indexPath.row].description
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(data[indexPath.row].description)
        self.note = data[indexPath.row].description
        //
        performSegue(withIdentifier: "goToShowNote", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(note)
        (segue.destination as? ShowNoteViewController)?.note = self.note

    }
    
    @IBAction func unWindSegue(segue : UIStoryboardSegue) {
        if segue.source is CreateNoteViewController {
            let vc = segue.source as! CreateNoteViewController
            let createNotes = vc.createNotes
            if createNotes != nil {
                data.append(createNotes!)
                print("date: \(createNotes!.date.description), desc: \(createNotes!.description)")
                tableViewNotes.insertRows(at: [IndexPath(row: data.count - 1, section: 0)], with: .automatic)
            }
        }
    }
    
    @IBAction func unWindSegueOne(segue : UIStoryboardSegue) {
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}



