//
//  Company+CoreDataProperties.swift
//  invoice-app
//
//  Created by Bartłomiej Gaweł on 19/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var name: String
}
