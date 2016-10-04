//
//  EntryController.swift
//  Journal
//
//  Created by Caleb Hicks on 10/1/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation
import CoreData

class EntryController {
    
    static let sharedController = EntryController()
    
    var entries: [Entry] {
        
		let request: NSFetchRequest<Entry> = NSFetchRequest(entityName: "Entry")
        
        do {
            return try Stack.sharedStack.managedObjectContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func addEntry(_ entry: Entry) {
        
        saveToPersistentStorage()
    }
    
    func removeEntry(_ entry: Entry) {
        
        entry.managedObjectContext?.delete(entry)
        saveToPersistentStorage()
    }
    
    func saveToPersistentStorage() {
        
        do {
            try Stack.sharedStack.managedObjectContext.save()
        } catch {
            print("Error saving Managed Object Context. Items not saved.")
        }
    }
    
}
