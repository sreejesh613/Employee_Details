//
//  Address+CoreDataClass.swift
//  Employee Details
//
//  Created by Sreejesh Krishnan on 11/09/22.
//
//

import Foundation
import CoreData

@objc(Address)
public class Address: NSManagedObject, Decodable {
    
    private enum CodingKeys: String, CodingKey { case city, street, suite, zip }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else { fatalError("NSManagedObjectContext is missing") }
        let entity = NSEntityDescription.entity(forEntityName: "Geo", in: context)!
        self.init(entity: entity, insertInto: context)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        street = try values.decodeIfPresent(String.self, forKey: .street)
        suite = try values.decodeIfPresent(String.self, forKey: .suite)
        zip = try values.decodeIfPresent(String.self, forKey: .zip)
    }
}
