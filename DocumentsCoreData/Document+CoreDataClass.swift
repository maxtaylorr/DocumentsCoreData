//
//  Document+CoreDataClass.swift
//  DocumentsCoreData
//
//  Created by Max Taylor on 2/22/19.
//  Copyright © 2019 Max Taylor. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Document)
public class Document: NSManagedObject {
    
    var date: Date? {
        get {
            return rawDate as Date?
        }
        set {
            rawDate = newValue as NSDate?
        }
    }
    
    convenience init?(name: String?, size: Int64, date: Date?, content: String?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        
        self.init(entity: Document.entity(), insertInto: managedContext)
        
        self.name = name
        self.date = date
        self.content = content
        self.size = size
        
    }
}
