//
//  EmployeeListModel.swift
//  EmployeeDetails_White_Rabbit
//
//  Created by Sreejesh Krishnan on 11/09/22.
//

import Foundation

struct EmployeeListModel : Codable {
    let id : Int?
    let name : String?
    let username : String?
    let email : String?
    let profile_image : String?
    let address : EmployeeAddress?
    let phone : String?
    let website : String?
    let company : EmployeeCompany?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case username = "username"
        case email = "email"
        case profile_image = "profile_image"
        case address = "address"
        case phone = "phone"
        case website = "website"
        case company = "company"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        profile_image = try values.decodeIfPresent(String.self, forKey: .profile_image)
        address = try values.decodeIfPresent(EmployeeAddress.self, forKey: .address)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        website = try values.decodeIfPresent(String.self, forKey: .website)
        company = try values.decodeIfPresent(EmployeeCompany.self, forKey: .company)
    }
}

struct EmployeeAddress: Codable {
    let street: String?
    let suite: String?
    let city: String?
    let zipCode: String?
    let geo: EmployeeGeo?
}

struct EmployeeGeo: Codable {
    let lat: String?
    let lng: String?
}

struct EmployeeCompany: Codable {
    let name: String?
    let catchPhrase: String?
    let bs: String?
}
