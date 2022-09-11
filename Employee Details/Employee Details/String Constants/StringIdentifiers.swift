//
//  StringIdentifiers.swift
//  Employee Details
//
//  Created by Sreejesh Krishnan on 11/09/22.
//

import Foundation

struct Identifiers {
    
    enum StoryboardName: String {
        case userDetails = "UserDetails"
    }
    
    struct NibNames {
        static let userListNib = "UserListTableViewCell"
        static let userDetailsNib = "UserDetailTableViewCell"
        static let profileImageNib = "ProfileImageTableViewCell"
        static let detailTextViewNib = "DetailTextViewTableViewCell"
    }
    
    struct CellIDs {
        static let userListCellId = "userListCell"
        static let userDetailCellId = "userDetailCell"
        static let profileImageCell = "profileImageCell"
        static let detailTextViewCell = "detailTextViewCell"
    }
    
    struct ViewControllerName {
        static let userListVC = "UsersListViewController"
        static let userDetailsVC = "UserDetailsViewController"
    }
    
    struct AssetIds {
        static let user_placeholder = "user_icon"
    }
}

struct StringConstants {
    static let name = "Name"
    static let userName = "User Name"
    static let email = "Email"
    static let address = "Address"
    static let phone = "Phone"
    static let website = "Website"
    static let company = "Company Details"
    static let notFound = "Not Found"
    static let addNotAvailable = "Address Not Available"
}
