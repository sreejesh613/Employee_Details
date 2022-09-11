//
//  EmployeeListViewModel.swift
//  Employee Details
//
//  Created by Sreejesh Krishnan on 11/09/22.
//

import Foundation
import UIKit

class EmployeeListViewModel {
    
    let connectionHandler = ConnectionHandler()
    
//    let context = DatabaseController.getContext()
    
    
    func fetchUserDetails(urlString: String, completion: @escaping (() -> Void)) {
        
        guard let url = URL(string: urlString) else { return }
        
        connectionHandler.makeWebRequest(url: url) { response, rawData, error in
            guard let error = error else {
                
                if let data = rawData {
                    do {
                        let model = try JSONDecoder().decode([EmployeeListModel].self, from: data)
                        
                        //Save items in the CoreData
                        self.saveEachModel(model: model)
                        
                        completion()
                    } catch {
                        completion()
                    }
                    
                } else {
                    //No data received
                    completion()
                }
                return
            }
            //Error found
            completion()
        }
    }
}

//Save Each address and company to CoreData
extension EmployeeListViewModel {
    
    func  saveEachModel(model: [EmployeeListModel]) {
        for each in model {
            
            //Check if data already exists in the CoreData memory
            guard let isDataExist = self.checkIfDataAlreadyExists(model: each) else { return }
            
            switch isDataExist {
            case .notExist:
                //Proceed with saving
                
                //Store User data to CoreData
                each.storeUserData()
                
                let id = each.id
                
                //Get each Address
                var address = each.getAddress()
                address?.id = id
                //Store Address data in CoreData
                address?.storeAddress()
                
                //Get each Company
                var company = each.getCompany()
                company?.id = id
                //Store Company data in CoreData
                company?.storeCompanyData()
                
            case .exists:
                //Data already exists
                //Return from the function
                continue
            case .unknown:
                //Unknown
                print("Unknown status of existence")
            }

        }
    }
}

//Extension to check if data already exists in the CoreData DB
extension EmployeeListViewModel {
    func checkIfDataAlreadyExists(model: EmployeeListModel) -> RecordStatus? {
        let database = DatabaseController.shared
        
        guard let email = model.email, let name = model.name else { return nil}
        
        return(database.checkIfDataAlreadyExists(email: email, name: name))
    }
}
