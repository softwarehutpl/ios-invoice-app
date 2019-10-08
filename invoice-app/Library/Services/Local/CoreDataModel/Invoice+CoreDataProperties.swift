//
//  Invoice+CoreDataProperties.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 08/10/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//
//

import Foundation
import CoreData


extension Invoice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Invoice> {
        return NSFetchRequest<Invoice>(entityName: "Invoice")
    }

    @NSManaged public var currency: String?
    @NSManaged public var date: String?
    @NSManaged public var dueDate: String?
    @NSManaged public var id: String?
    @NSManaged public var invoiceTitle: String?
    @NSManaged public var paymentMethod: String?
    @NSManaged public var status: Bool
    @NSManaged public var client: Client?
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension Invoice {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}
