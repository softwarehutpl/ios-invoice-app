//
//  Client+CoreDataProperties.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 26/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//
//

import Foundation
import CoreData


extension Client {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Client> {
        return NSFetchRequest<Client>(entityName: "Client")
    }

    @NSManaged public var name: String
    @NSManaged public var email: String
    @NSManaged public var phone: String
    @NSManaged public var address: String
    @NSManaged public var postcode: String
    @NSManaged public var city: String
    @NSManaged public var country: String
}
