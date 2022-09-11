//
//  ConnectionHandler.swift
//  Employee Details
//
//  Created by Sreejesh Krishnan on 11/09/22.
//

import Foundation

class ConnectionHandler {
    
    var session = URLSession.shared
    
    //MARK: UNIVERSAL WEB REQUEST
    func makeWebRequest(url: URL, completion: @escaping (HTTPURLResponse?, _ rawData: Data?, Error?) -> Void) {
        
        let task = session.dataTask(with: url) { data, response, error in
                guard
                    let httpResponse = response as? HTTPURLResponse,
                    200..<300 ~= httpResponse.statusCode
                else {
                    // handle invalid Http return code
                    completion(nil, nil, error)
                    return
                }
                completion(httpResponse, data, nil)
            }
        task.resume()
    }
}
