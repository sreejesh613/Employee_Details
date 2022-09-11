//
//  Geo+CoreDataProperties.swift
//  Employee Details
//
//  Created by Sreejesh Krishnan on 11/09/22.
//
//

import Foundation
import CoreData


extension Geo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Geo> {
        return NSFetchRequest<Geo>(entityName: "Geo")
    }

    @NSManaged public var id: Int16
    @NSManaged public var lat: String?
    @NSManaged public var long: String?

}

extension Geo : Identifiable {

}
