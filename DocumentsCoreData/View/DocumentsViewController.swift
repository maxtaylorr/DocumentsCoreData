//
//  DocumentsViewController.swift
//  DocumentsCoreData
//
//  Created by Max Taylor on 2/22/19.
//  Copyright © 2019 Max Taylor. All rights reserved.
//

import UIKit
import CoreData

class DocumentsViewController: UIViewController {

    @IBOutlet weak var documentsTableView: UITableView!
    
    let dateFormatter = DateFormatter()
    
    var documents = [Document]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .long
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Document> = Document.fetchRequest()
        
        do {
            documents = try managedContext.fetch(fetchRequest)
            
            documentsTableView.reloadData()
        } catch {
            print("Fetch could not be performed")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SingleDocumentViewController,
            let selectedRow = self.documentsTableView.indexPathForSelectedRow?.row else {
                return
        }
        
        destination.existingDocument = documents[selectedRow]
    }
    
}

extension DocumentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = documentsTableView.dequeueReusableCell(withIdentifier: "documentCell", for: indexPath)
        let document = documents[indexPath.row]

        if let cell = cell as? DocumentsTableViewCell {
            cell.nameLabel.text = document.name
            cell.dataLabel.text = String(document.size)
            cell.dateLabel.text = dateFormatter.string(from: document.date!)
        }
        
        return cell
    }
}

extension DocumentsViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
