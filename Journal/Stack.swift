//
//  Stack.swift
//


import Foundation
import CoreData

enum CoreDataStack {
	
	static let container: NSPersistentContainer = {
		
		let container = NSPersistentContainer(name: "PlaylistCoreData")
		container.loadPersistentStores() { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		}
		return container
	}()
	
	static var context: NSManagedObjectContext { return container.viewContext }
}
