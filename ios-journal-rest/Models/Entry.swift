//
//  Entry.swift
//  ios-journal-rest
//
//  Created by Conner on 8/9/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import Foundation

struct Entry: Equatable, Codable {

    init(title: String, bodyText: String, timestamp: Date, identifier: String) {
        self.title = title
        self.bodyText = bodyText
        self.timestamp = Date()
        self.identifier = UUID().uuidString
    }

    var title: String
    var bodyText: String
    let timestamp: Date
    let identifier: String

}
