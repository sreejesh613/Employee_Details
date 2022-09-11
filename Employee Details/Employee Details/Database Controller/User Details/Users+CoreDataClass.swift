//
//  Users+CoreDataClass.swift
//  Employee Details
//
//  Created by Sreejesh Krishnan on 11/09/22.
//
//

import Foundation
import CoreData

@objc(Users)
public class Users: NSManagedObject, Decodable {

    private enum CodingKeys: String, CodingKey { case email, id, name, phone, profileImage, userName, website }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[.context] as? NSManagedObjectContext else { fatalError("NSManagedObjectContext is missing") }
        let entity = NSEntityDescription.entity(forEntityName: "Geo", in: context)!
        self.init(entity: entity, insertInto: context)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        id = try values.decodeIfPresent(Int16.self, forKey: .id) ?? 0
        name = try values.decodeIfPresent(String.self, forKey: .name)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
        website = try values.decodeIfPresent(String.self, forKey: .website)
    }
    
}
