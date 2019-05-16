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

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableViewNotes: UITableView!
    @IBOutlet weak var searchNote: UISearchBar!
    @IBAction func item(_ sender: UIBarButtonItem) {
        
    }
    
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
    
    var searchActive : Bool = false
    var filtered: [Notes] = []
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
        data = notesManager.getAllNotes()
        filtered = notesManager.getAllNotes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notesManager.index = 0
        filtered = notesManager.getAllNotes()
        searchActive = false
        searchNote.text = ""
        searchNote.endEditing(true)
        searchNote.showsCancelButton = false
        tableViewNotes.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        notesManager.index = 0
        filtered = notesManager.getAllNotes()
        searchActive = false
        searchNote.text = ""
        searchNote.endEditing(true)
        searchNote.showsCancelButton = false
        tableViewNotes.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewNotes.dequeueReusableCell(withIdentifier: "notesCell") as! NotesTableViewCell
        if searchActive == false, indexPath.row == filtered.count - 1, notesManager.countNotes() > notesManager.limit{
            if filtered.count < notesManager.countNotes() {
                notesManager.index = indexPath.row + 1
                data += notesManager.getAllNotes()
                filtered += notesManager.getAllNotes()
                tableViewNotes.reloadData()
            }
        }
        let notes = filtered[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:MM"
        cell.dateLablel.text = dateFormatter.string(from: notes.creationDate! as Date)
        cell.descLabel.text = notes.descriptionNote
        let nsString = notes.descriptionNote! as NSString
        if let countLabel = cell.descLabel.text?.count, countLabel > 100
        {
            cell.descLabel.text = nsString.substring(with: NSRange(location: 0, length: countLabel > 100 ? 100 : countLabel))
        }
        cell.timeLabel.text = timeFormatter.string(from: notes.creationDate! as Date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            self.goToEdit(indexPath: indexPath)
        })
        editAction.backgroundColor = UIColor.blue
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            notesManager.removeNote(notes: self.filtered[indexPath.row])
            self.filtered.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableViewNotes.reloadData()
            notesManager.saveNote()
        })
        deleteAction.backgroundColor = UIColor.red
        return [editAction, deleteAction]
    }
    
    func goToEdit(indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        controller.editNote = self.filtered[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
        tableViewNotes.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.note = filtered[indexPath.row]
        performSegue(withIdentifier: "goToShowNote", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(note)
        (segue.destination as? ShowNoteViewController)?.note = self.note
    }
    
    @IBAction func unWindSegueOne(segue : UIStoryboardSegue) {
        tableViewNotes.reloadData()
    }
}

extension ViewController : UISearchBarDelegate {
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
        searchNote.text = ""
        notesManager.index = 0
        filtered = notesManager.getAllNotes()
        self.tableViewNotes.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty, filtered.count < notesManager.countNotes() {
            notesManager.limit = notesManager.countNotes()
            notesManager.index = 0
            
            data = []
            data = notesManager.getAllNotes()
            notesManager.limit = 20
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
            filtered = notesManager.getAllNotes()
        }
        self.tableViewNotes.reloadData()
    }
}
