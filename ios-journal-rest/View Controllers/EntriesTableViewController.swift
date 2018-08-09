//
//  EntriesTableViewController.swift
//  ios-journal-rest
//
//  Created by Conner on 8/9/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit

class EntriesTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        entryController.fetchEntries { (error) in
            if let error = error {
                NSLog("error fetching entries in EntriesTableViewController: \(error)")
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        super.viewWillAppear(animated)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryController.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalEntryCell", for: indexPath) as! EntryTableViewCell
        cell.entry = entryController.entries[indexPath.row]

        return cell
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // ViewExistingJournalEntrySegue && CreateJournalEntrySegue
        if segue.identifier == "ViewExistingJournalEntrySegue" {
            if let vc = segue.destination as? EntryDetailViewController {
                vc.entryController = entryController
                
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    vc.entry = entryController.entries[indexPath.row]
                }
            }
        } else if segue.identifier == "CreateJournalEntrySegue" {
            if let vc = segue.destination as? EntryDetailViewController {
                vc.entryController = entryController
            }
        }
    }
    
    // MARK: - Properties
    let entryController: EntryController = EntryController()
}
