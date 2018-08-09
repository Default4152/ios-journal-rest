//
//  EntryController.swift
//  ios-journal-rest
//
//  Created by Conner on 8/9/18.
//  Copyright © 2018 Conner. All rights reserved.
//

import Foundation

class EntryController {
    
    func fetchEntries(completion: @escaping (Error?) -> Void) {
        let url = baseURL.appendingPathExtension("json")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error GET entries: \(error)")
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let entries = try decoder.decode([Entry].self, from: data)
                    let sortedEntries = entries.sorted(by: { $0.timestamp <= $1.timestamp })
                    self.entries = sortedEntries
                } catch {
                    NSLog("Error decoding data from GET")
                }
            }
        }
    }
    
    func update(entry: Entry, title: String, bodyText: String, completion: @escaping (Error?) -> Void) {
        var scratchEntry = entry
        scratchEntry.title = title
        scratchEntry.bodyText = bodyText
        
        put(entry: scratchEntry) { (error) in
            if let error = error {
                NSLog("Error updating entry: \(error)")
            }
        }
    }
    
    func createEntry(title: String, bodyText: String, completion: @escaping (Error?) -> Void) {
        let entry = Entry(title: title, bodyText: bodyText)
        put(entry: entry) { (error) in
            if let error = error {
                NSLog("Error PUT entry: \(error)")
            }
        }
    }
    
    
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
