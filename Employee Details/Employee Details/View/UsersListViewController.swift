//
//  UsersListViewController.swift
//  Employee Details
//
//  Created by Sreejesh Krishnan on 11/09/22.
//

import UIKit

class UsersListViewController: BaseViewController {

    //Properties
    var userDetailsVM: EmployeeDetailsViewModel?
    
    //View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        userDetailsVM = EmployeeDetailsViewModel()
        checkForStoredData()
    }
    
    //Methods
    fileprivate func checkForStoredData() {
        //If stored data in nil
        //Initiate API call
        self.getDataFromTheServer()
    }
    
    
}

//MARK: API HANDLING
extension UsersListViewController {

    func getDataFromTheServer() {
        //Show activity indicator
        self.showActivityIndicatorWithText(text: "Getting data from the server..")
        
        //Initiate API call
        userDetailsVM?.fetchUserDetails(urlString: API.baseUrl, completion: { response, error in
            //Stop activity indicator
            self.stopActivityIndicator()
            
            guard let error = error else {
                //No error
                if let data = response {
                    print("Data received from the server: \(data)")
                } else {
                    
                }
                return
            }
            //Error found
            self.showAlert(title: "Error", message: error.localizedDescription, actionTitles: ["OK"], actions: [nil])
        })
    }
}
