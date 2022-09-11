//
//  Extensions.swift
//  Employee Details
//
//  Created by Sreejesh Krishnan on 11/09/22.
//

import Foundation
import CoreData

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")!
}

extension JSONDecoder {
    convenience init(context: NSManagedObjectContext) {
        self.init()
        self.userInfo[.context] = context
    }
}
