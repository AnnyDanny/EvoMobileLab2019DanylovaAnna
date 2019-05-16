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
            self.filtered = self.filtered.sorted(){$0.creationDate! > $1.creationDate!}
            self.tableViewNotes.reloadData()
        }
        let action2 = UIAlertAction(title: "From old to new", style: .default) { (action: UIAlertAction) in
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
    
    @IBAction func item(_ sender: UIBarButtonItem) {
        
    }
    
    var data = [Notes]()
    var note: Notes!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewNotes.dataSource = self
        tableViewNotes.delegate = self
        searchNote.delegate = self
        tableViewNotes.rowHeight = UITableViewAutomaticDimension
        notesManager.managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        notesManager.index = 0
        data = notesManager.getAllArticles()
        filtered = notesManager.getAllArticles()
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
        notesManager.index = 0
        filtered = notesManager.getAllArticles()
        self.tableViewNotes.reloadData()
    }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if !searchText.isEmpty, filtered.count < notesManager.countNotes() {
                notesManager.limit = notesManager.countNotes()
                notesManager.index = 0
                
                data = []
                data = notesManager.getAllArticles()
                notesManager.limit = 10
            }
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
                notesManager.index = 0
                filtered = notesManager.getAllArticles()
            }
        self.tableViewNotes.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notesManager.index = 0
        data = notesManager.getAllArticles()
        filtered = notesManager.getAllArticles()
        tableViewNotes.reloadData()
        print("filtered2: \(filtered)\n")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        notesManager.index = 0
        data = notesManager.getAllArticles()
        filtered = notesManager.getAllArticles()
        tableViewNotes.reloadData()
        print("filtered3: \(filtered)\n")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewNotes.dequeueReusableCell(withIdentifier: "notesCell") as! NotesTableViewCell
        print("\nindexPathRow: \(indexPath.row)\n")
//
        if searchActive == false, indexPath.row == filtered.count - 1, notesManager.countNotes() > notesManager.limit{
            if filtered.count < notesManager.countNotes() {
                print("count notes: \(notesManager.countNotes())\n")
                notesManager.index = indexPath.row + 1
                data += notesManager.getAllArticles()
                filtered += notesManager.getAllArticles()
                tableViewNotes.reloadData()
            }
        }
        let notes = filtered[indexPath.row]
        //        if indexPath.row % 2 == 0 {
//            cell.contentView.backgroundColor = UIColor.purple
//        }
//        else {
//            cell.contentView.backgroundColor = UIColor.lightGray
//        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:MM"
        
        cell.dateLablel.text = dateFormatter.string(from: notes.creationDate! as Date)
        cell.descLabel.text = notes.descriptionNote
        cell.timeLabel.text = timeFormatter.string(from: notes.creationDate! as Date)

        
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
        tableViewNotes.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(filtered[indexPath.row].descriptionNote)
        self.note = filtered[indexPath.row]
        performSegue(withIdentifier: "goToShowNote", sender: self)
        print("data5: \(data)\n")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(note)
        (segue.destination as? ShowNoteViewController)?.note = self.note
    }
    
    @IBAction func unWindSegueOne(segue : UIStoryboardSegue) {
        tableViewNotes.reloadData()
    }
}



