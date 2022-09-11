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
    }
    
    struct CellIDs {
        static let userListCellId = "userListCell"
        static let userDetailCellId = "userDetailCell"
    }
    
    struct ViewControllerName {
        static let userListVC = "UsersListViewController"
        static let userDetailsVC = "UserDetailsViewController"
    }
    
    struct AssetIds {
        static let user_placeholder = "user_icon"
    }
}
