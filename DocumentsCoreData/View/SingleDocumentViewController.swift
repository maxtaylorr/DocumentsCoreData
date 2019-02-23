//
//  SingleDocumentViewController.swift
//  DocumentsCoreData
//
//  Created by Max Taylor on 2/22/19.
//  Copyright © 2019 Max Taylor. All rights reserved.
//

import UIKit
import CoreData

class SingleDocumentViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dataTextField: UITextView!
    var existingDocument: Document?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.text = existingDocument?.name
        dataTextField.text = existingDocument?.content
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let name = nameTextField.text
        let bodyText = dataTextField.text
        let size = Int64((bodyText?.lengthOfBytes(using: .utf8))!)
        
        
        // this seems like such a messy way to set up the date but I couldn't find/think of anything better
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "MMM d, yyyy at h:mm a"
        let dateString = dateFormatter.string(from: now)
        guard let newDate = dateFormatter.date(from: dateString) else { return }
                
        var document: Document?
        
        if let existingDocument = existingDocument {
            existingDocument.name = name
            existingDocument.size = size
            existingDocument.date = newDate
            existingDocument.content = bodyText
            
            document = existingDocument
        } else {
            document = Document(name: name, size: size, date: newDate, content: bodyText)
        }
        
        
        if let document = document {
            do {
                let managedContext = document.managedObjectContext
                
                try managedContext?.save()
                
                self.navigationController?.popViewController(animated: true)
            } catch {
                print("Document could not be saved.")
            }
        }
        
        self.navigationController?.popViewController(animated: trues)
    }
    
    @IBAction func namedChanged(_ sender: Any) {
        title = nameTextField.text

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
