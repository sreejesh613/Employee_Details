//
//  EmployeeDetailsViewModel.swift
//  Employee Details
//
//  Created by Sreejesh Krishnan on 11/09/22.
//

import Foundation

class EmployeeDetailsViewModel {
    
    let connectionHandler = ConnectionHandler()
    
    typealias completionHandler = ((_ response: [EmployeeListModel]?, _ error: Error?) -> Void)
    
    func fetchUserDetails(urlString: String, completion: @escaping completionHandler) {
        guard let url = URL(string: urlString) else { return }
        connectionHandler.makeWebRequest(url: url) { response, rawData, error in
            guard let error = error else {
                if let data = rawData {
                    do {
                        let decoder = JSONDecoder()
                        let data = try decoder.decode([EmployeeListModel].self, from: data)
                        completion(data, nil)
                    } catch {
                        completion(nil, error)
                    }
                    
                } else {
                    //No data received
                    completion(nil, nil)
                }
                return
            }
            //Error found
            completion(nil, error)
        }
    }
}
