//
//  EmployeeDetailsViewModel.swift
//  Employee Details
//
//  Created by Sreejesh Krishnan on 11/09/22.
//

import Foundation
import UIKit

class EmployeeDetailsViewModel {
    
    let connectionHandler = ConnectionHandler()
    
    let context = DatabaseController.getContext()
    
    typealias completionHandler = ((_ response: JSONDecoder?, _ error: Error?) -> Void)
    
    func fetchUserDetails(urlString: String, completion: @escaping completionHandler) {
        guard let url = URL(string: urlString) else { return }
        connectionHandler.makeWebRequest(url: url) { response, rawData, error in
            guard let error = error else {
                
                let decoder = JSONDecoder(context: self.context)
                completion(decoder, nil)
                
//                if let data = rawData {
//                    do {
//                        let decoder = JSONDecoder(context: self.context)
//                        completion(decoder, nil)
//                    } catch {
//                        completion(nil, error)
//                    }
//
//                } else {
//                    //No data received
//                    completion(nil, nil)
//                }
                return
            }
            //Error found
            completion(nil, error)
        }
    }
}
