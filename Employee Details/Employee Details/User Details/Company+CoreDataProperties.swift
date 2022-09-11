//
//  Company+CoreDataProperties.swift
//  Employee Details
//
//  Created by Sreejesh Krishnan on 11/09/22.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var name: String?
    @NSManaged public var catchPhrase: String?
    @NSManaged public var bs: String?

}

extension Company : Identifiable {

}
