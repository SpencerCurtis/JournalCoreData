//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Caleb Hicks on 10/3/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		updateViews()
	}
	
	// MARK: Actions
	
    @IBAction func saveButtonTapped(_ sender: AnyObject) {
        
        if let entry = self.entry {
            entry.title = self.titleTextField.text!
            entry.text = self.bodyTextView.text
            entry.timestamp = Date() as NSDate
        } else {
            let newEntry = Entry(title: self.titleTextField.text!, text: self.bodyTextView.text)
			EntryController.sharedController.add(entry: newEntry)
            self.entry = newEntry
        }
        
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearButtonTapped(_ sender: AnyObject) {
        
        titleTextField.text = ""
        bodyTextView.text = ""
    }
	
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
	
	// MARK: Private
	
	private func updateViews() {
		guard let entry = entry else { return }
		self.titleTextField.text = entry.title
		self.bodyTextView.text = entry.text
	}
	
	// MARK: Properties
	
	var entry: Entry? {
		didSet {
			updateViews()
		}
	}

	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var bodyTextView: UITextView!
}
