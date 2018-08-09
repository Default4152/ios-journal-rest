//
//  EntryController.swift
//  ios-journal-rest
//
//  Created by Conner on 8/9/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import Foundation

class EntryController {
    
    func put(entry: Entry, completion: @escaping (Error?) -> Void) {
        let url = baseURL
            .appendingPathComponent(entry.identifier)
            .appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(entry)
            request.httpBody = data
        } catch {
            NSLog("Could not encode Entry: \(entry)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error with PUT request")
                completion(error)
                return
            }
        }.resume()
    }
    
    
    //MARK: - Properties
    var entries: [Entry] = []
    let baseURL = URL(string: "https://journalapp-acf5b.firebaseio.com/")!
    
}
