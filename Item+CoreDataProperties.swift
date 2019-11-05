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

    class func create(context: NSManagedObjectContext, items: [ItemModel], invoice: Invoice) {
        items.forEach { (item) in
            let itemToAdd = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context) as! Item
            itemToAdd.amount = item.amount
            itemToAdd.itemName = item.itemName
            itemToAdd.price = item.price
            itemToAdd.tax = item.tax
            itemToAdd.id = item.id
            itemToAdd.invoice = invoice
        }
    }
    class func convert(context: NSManagedObjectContext, item: ItemModel) {
        let itemToCheck = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context) as! Item
        itemToCheck.itemName = item.itemName
        itemToCheck.amount = item.amount
        itemToCheck.tax = item.tax
        itemToCheck.price = item.price
        itemToCheck.id = item.id
        
    }
}