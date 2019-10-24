//
//  Client+CoreDataProperties.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 18/10/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//
//

import Foundation
import CoreData


extension Client {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Client> {
        return NSFetchRequest<Client>(entityName: "Client")
    }

    @NSManaged public var address: String
    @NSManaged public var city: String
    @NSManaged public var country: String
    @NSManaged public var email: String
    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var phone: String
    @NSManaged public var postcode: String
    @NSManaged public var invoices: NSSet?

}

// MARK: Generated accessors for invoices
extension Client {

    @objc(addInvoicesObject:)
    @NSManaged public func addToInvoices(_ value: Invoice)

    @objc(removeInvoicesObject:)
    @NSManaged public func removeFromInvoices(_ value: Invoice)

    @objc(addInvoices:)
    @NSManaged public func addToInvoices(_ values: NSSet)

    @objc(removeInvoices:)
    @NSManaged public func removeFromInvoices(_ values: NSSet)

    class func create(context: NSManagedObjectContext, client: ClientModel) -> Client {
        let clientToCreate = NSEntityDescription.insertNewObject(forEntityName: "Client", into: context) as! Client
        clientToCreate.address = client.address
        clientToCreate.city = client.city
        clientToCreate.country = client.country
        clientToCreate.email = client.email
        clientToCreate.id = client.id
        clientToCreate.name = client.name
        clientToCreate.phone = client.phone
        clientToCreate.postcode = client.postcode
        clientToCreate.address = client.address
        return clientToCreate
    }
}
