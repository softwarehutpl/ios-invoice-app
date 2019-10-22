//
//  Item+CoreDataProperties.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 17/10/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var amount: String
    @NSManaged public var itemName: String
    @NSManaged public var price: String
    @NSManaged public var tax: String
    @NSManaged public var id: String
    @NSManaged public var invoice: Invoice

}
