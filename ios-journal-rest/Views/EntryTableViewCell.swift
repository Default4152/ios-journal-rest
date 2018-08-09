//
//  EntryTableViewCell.swift
//  ios-journal-rest
//
//  Created by Conner on 8/9/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Properties
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateTimeLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
}
