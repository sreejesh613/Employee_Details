//
//  Geo+CoreDataClass.swift
//  Employee Details
//
//  Created by Sreejesh Krishnan on 11/09/22.
//
//

import Foundation
import CoreData

@objc(Geo)
public class Geo: NSManagedObject, Decodable {

    private enum CodingKeys: String, CodingKey { case lat, long }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else { fatalError("NSManagedObjectContext is missing") }
        let entity = NSEntityDescription.entity(forEntityName: "Geo", in: context)!
        self.init(entity: entity, insertInto: context)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        long = try values.decodeIfPresent(String.self, forKey: .long)
    }
}
