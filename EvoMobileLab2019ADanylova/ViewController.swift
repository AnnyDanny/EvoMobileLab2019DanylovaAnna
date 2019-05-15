//
//  ViewController.swift
//  EvoMobileLab2019ADanylova
//
//  Created by Ganna DANYLOVA on 5/10/19.
//  Copyright © 2019 Ganna DANYLOVA. All rights reserved.
//

import UIKit
import CoreData

var notesManager = NotesManager()



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableViewNotes: UITableView!
    
    @IBAction func sortingButton(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "From new to old", style: .default) { (action: UIAlertAction) in
            print("You've pressed the destructive");
            self.filtered = self.filtered.sorted(){$0.creationDate! > $1.creationDate!}
            self.tableViewNotes.reloadData()
//            convertedArray.sorted(by: {$0.timeIntervalSince1970 < $1.timeIntervalSince1970})
        }
        let action2 = UIAlertAction(title: "From old to new", style: .default) { (action: UIAlertAction) in
            print("You've pressed the destructive");
            self.filtered = self.filtered.sorted(){$0.creationDate! < $1.creationDate!}
            self.tableViewNotes.reloadData()
        }
        let action3 = UIAlertAction(title: "Cancel", style: .cancel) { (action: UIAlertAction) in
            print("You've pressed cancel");
        }
        alertController.addAction(action1)
        alertController.addAction(action2)
        alertController.addAction(action3)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBOutlet weak var searchNote: UISearchBar!
    
    var searchActive : Bool = false
    var filtered: [Notes] = []
//    var filtered: Notes?
//    var filtered: String?
    
    @IBAction func item(_ sender: UIBarButtonItem) {
        
    }
    
//    var notesManager = NotesManager()
    
    var data = [Notes]()
//    var data: [NSManagedObject] = []
    var note: Notes!

//    func searchBar(_ searchBar: UISearchBar,
//                            textDidChange searchText: String) {
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewNotes.dataSource = self
        tableViewNotes.delegate = self
        searchNote.delegate = self
//        tableViewNotes.estimatedRowHeight = 200
        tableViewNotes.rowHeight = UITableViewAutomaticDimension
        notesManager.managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        data = notesManager.getAllArticles()
        filtered = data
        print("data1: \(data)\n")
//        createDefaultNote()
//        let imageForTitle = "notes"
//        let image = UIImage(named: imageForTitle)
//        image.contentMode = .scaleAspectFit
//        navigationItem.titleView = UIImageView(image: image)
//        navigationItem.rightBarButtonItem = editButtonItem
//        updateEditButtonState()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
        searchNote.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        searchNote.endEditing(true)
        searchNote.showsCancelButton = false
        filtered = notesManager.getAllArticles()
        self.tableViewNotes.reloadData()
    }

    

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        print("hello search")
        filtered = data.filter({ (text) -> Bool in

            let tmp: String? = text.descriptionNote
            let range = tmp?.range(of: searchText, options: .caseInsensitive)
            return (range != nil)
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
            if searchText == "" {
                filtered = notesManager.getAllArticles()
            }
        self.tableViewNotes.reloadData()
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        data = notesManager.getAllArticles()
        filtered = notesManager.getAllArticles()
        tableViewNotes.reloadData()
        print("data2: \(data)\n")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        data = notesManager.getAllArticles()
        filtered = notesManager.getAllArticles()
        print("data3: \(data)\n")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewNotes.dequeueReusableCell(withIdentifier: "notesCell") as! NotesTableViewCell
        let notes = filtered[indexPath.row]
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = UIColor.purple
        }
        else {
            cell.contentView.backgroundColor = UIColor.lightGray
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.mm.yy"
        
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:MM"
        
        cell.dateLablel.text = dateFormatter.string(from: notes.creationDate! as Date)
        cell.descLabel.text = notes.descriptionNote
        cell.timeLabel.text = timeFormatter.string(from: notes.creationDate! as Date)
//        cell.dateLablel.text = dateFormatter.string(from: data[indexPath.row].creationDate! as Date)
//        cell.descLabel.text = data[indexPath.row].descriptionNote
        
        
//        print("data4: \(data)\n")
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            print("Edit tapped")
            self.goToEdit(indexPath: indexPath)
        })
        editAction.backgroundColor = UIColor.blue
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            print("Delete tapped")
            notesManager.managedObjectContext?.delete(self.filtered[indexPath.row])
            self.filtered.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableViewNotes.reloadData()
//            NoteHandler.shared.appDelegate?.saveContext()
            notesManager.save()
        })
        deleteAction.backgroundColor = UIColor.red
        
        return [editAction, deleteAction]
    }
    
    func goToEdit(indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
//        self.present(controller, animated: true, completion: nil)
        controller.editNote = self.filtered[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//
//        if editingStyle == .delete {
//
//            // remove the item from the data model
//            note.remove(at: indexPath.row)
//
//            // delete the table view row
//            tableView.deleteRows(at: [indexPath], with: .fade)
//
//        } else if editingStyle == .insert {
//            // Not used in our example, but if you were adding a new row, this is where you would do it.
//        }
//    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(filtered[indexPath.row].descriptionNote)
        self.note = filtered[indexPath.row]
        //
        performSegue(withIdentifier: "goToShowNote", sender: self)
        print("data5: \(data)\n")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(note)
        (segue.destination as? ShowNoteViewController)?.note = self.note
        //(segue.destination as? EditViewController)?.editNote = self.note
//        (segue.destination as? CreateNoteViewController)?.notesManager = self.notesManager
    }
    
//    @IBAction func unWindSegue(segue : UIStoryboardSegue) {
//        if segue.source is CreateNoteViewController {
//            let vc = segue.source as! CreateNoteViewController
//            let createNotes = vc.notesManager
//
//            if createNotes != nil {
//                data.append(createNotes!)
//                print("date: \(String(describing: createNotes!.creationDate?.description)), desc: \(createNotes!.descriptionNote)")
//                tableViewNotes.insertRows(at: [IndexPath(row: data.count - 1, section: 0)], with: .automatic)
//            }
//        }
//    }
    
    @IBAction func unWindSegueOne(segue : UIStoryboardSegue) {
        tableViewNotes.reloadData()
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
    
}



