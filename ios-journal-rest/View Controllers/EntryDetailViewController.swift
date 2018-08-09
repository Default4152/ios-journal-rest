//
//  EntryDetailViewController.swift
//  ios-journal-rest
//
//  Created by Conner on 8/9/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    func updateViews() {
        title = entry?.title

        guard let textField = textField,
            let textView = textView else { return }

        textField.text = entry?.title
        textView.text = entry?.bodyText
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    @IBAction func save(_ sender: Any) {
        guard let textField = textField.text,
            let textView = textView.text else { return }

        if let entry = entry {
            entryController?.update(entry: entry, title: textField, bodyText: textView, completion: { (error) in
                if let error = error {
                    NSLog("Error saving updated journal entry: \(error)")
                }

                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            })
        } else {
            entryController?.createEntry(title: textField, bodyText: textView, completion: { (error) in
                if let error = error {
                    NSLog("Error creating new journal entry: \(error)")
                }
            })

            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    // MARK: - Properties
    @IBOutlet var textField: UITextField!
    @IBOutlet var textView: UITextView!

    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
    var entryController: EntryController?
}
