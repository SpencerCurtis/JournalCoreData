//
//  ListTableViewController.swift
//  Journal
//
//  Created by Caleb Hicks on 10/3/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit
import CoreData

class EntryListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		fetchedResultsController.delegate = self
		do {
			try fetchedResultsController.performFetch()
		} catch {
			NSLog("Error starting fetched results controller: \(error)")
		}
	}
	
	// MARK: UITableViewDataSource/Delegate
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return fetchedResultsController.fetchedObjects?.count ?? 0
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
		
		guard let entry = fetchedResultsController.fetchedObjects?[indexPath.row] else { return cell }
		
		cell.textLabel?.text = entry.title
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			
			if let entry = fetchedResultsController.fetchedObjects?[indexPath.row] {
				EntryController.sharedController.remove(entry: entry)
			}
		}
	}
	
	// MARK: NSFetchedResultsControllerDelegate
	
	func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
	                didChange anObject: Any,
	                at indexPath: IndexPath?,
	                for type: NSFetchedResultsChangeType,
	                newIndexPath: IndexPath?) {
		switch type {
		case .delete:
			guard let indexPath = indexPath else { return }
			tableView.deleteRows(at: [indexPath], with: .fade)
		case .insert:
			guard let newIndexPath = newIndexPath else { return }
			tableView.insertRows(at: [newIndexPath], with: .automatic)
		case .move:
			guard let indexPath = indexPath,
				let newIndexPath = newIndexPath else { return }
			tableView.moveRow(at: indexPath, to: newIndexPath)
		case .update:
			guard let indexPath = indexPath else { return }
			tableView.reloadRows(at: [indexPath], with: .automatic)
		}
	}
	
	// MARK: Navigation
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if segue.identifier == "toShowEntry" {
			
			if let detailViewController = segue.destination as? EntryDetailViewController {
				
				// Following line forces the view from Storyboard to load UI elements to make available for testing
				detailViewController.loadViewIfNeeded()
				
				if let selectedRow = tableView.indexPathForSelectedRow?.row,
					let entry = fetchedResultsController.fetchedObjects?[selectedRow] {
					detailViewController.entry = entry
				}
			}
		}
	}
	
	// MARK: Properties
	
	let fetchedResultsController: NSFetchedResultsController<Entry> = {
		let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
		fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
		
		return NSFetchedResultsController(fetchRequest: fetchRequest,
		                                  managedObjectContext: CoreDataStack.context,
		                                  sectionNameKeyPath: nil,
		                                  cacheName: nil)
	}()
}
