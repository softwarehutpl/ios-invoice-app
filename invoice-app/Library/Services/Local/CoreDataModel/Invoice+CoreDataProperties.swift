//
//  Invoice+CoreDataProperties.swift
//  
//
//  Created by Damian Szejnoch on 13/09/2019.
//
//

import Foundation
import CoreData


extension Invoice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Invoice> {
        return NSFetchRequest<Invoice>(entityName: "Invoice")
    }

    @NSManaged public var amount: String
    @NSManaged public var date: String
    @NSManaged public var dueDate: String
    @NSManaged public var invoiceTitle: String
    @NSManaged public var status: Bool
    @NSManaged public var id: String
    @NSManaged public var client: Client

}
