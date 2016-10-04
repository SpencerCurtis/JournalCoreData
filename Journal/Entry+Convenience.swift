//
//  Entry+Convenience.swift
//  Journal
//
//  Created by Andrew Madsen on 10/4/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData

extension Entry {
	
	    convenience init(title: String, text: String, timestamp: Date = Date(), context: NSManagedObjectContext = CoreDataStack.context) {
	
			self.init(context: context)

			self.title = title
	        self.text = text
	        self.timestamp = timestamp as NSDate
	    }
	
	
}
