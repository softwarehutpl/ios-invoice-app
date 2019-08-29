//
//  Invoice+CoreDataProperties.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 28/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
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
    @NSManaged public var client: Client

}
