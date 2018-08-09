//
//  EntryTableViewCell.swift
//  ios-journal-rest
//
//  Created by Conner on 8/9/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {
    
    func updateViews() {
        guard let titleLabel = titleLabel,
            let dateTimeLabel = dateTimeLabel,
            let descriptionLabel = descriptionLabel else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm"
        
        if let entry = entry {
            titleLabel.text = entry.title
            dateTimeLabel.text = dateFormatter.string(from: entry.timestamp)
            descriptionLabel.text = entry.bodyText
        }
    }

    // MARK: - Properties
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateTimeLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
}
