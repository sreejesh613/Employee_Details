//
//  UsersListViewController.swift
//  Employee Details
//
//  Created by Sreejesh Krishnan on 11/09/22.
//

import UIKit
import SDWebImage

class UsersListViewController: BaseViewController {

    //Outlets
    @IBOutlet weak var userListTableView: UITableView!
    
    //Properties
    var userDetailsVM: EmployeeDetailsViewModel?
    var users: [EmployeeListModel]?
    
    //View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        userDetailsVM = EmployeeDetailsViewModel()
        registerCustomCell()
        checkForStoredData()
    }
    
    //Methods
    fileprivate func checkForStoredData() {
        //If stored data in nil
        //Initiate API call
        self.getDataFromTheServer()
    }
    
    //Register custom cells
    fileprivate func registerCustomCell() {
        let userNib = UINib(nibName: Identifiers.NibNames.userListNib, bundle: nil)
        userListTableView.register(userNib, forCellReuseIdentifier: Identifiers.CellIDs.userListCellId)
    }
    
    //Reload Tableview
    fileprivate func reloadTableView() {
        DispatchQueue.main.async {
            self.userListTableView.reloadData()
        }
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
                    print("JSONDecoder data received: \(data)")
                    //Save the decoded values to Core data
                    DatabaseController.saveContext()
                    //Reload tableview
                    self.reloadTableView()
                } else {
                    
                }
                return
            }
            //Error found
            self.showAlert(title: "Error", message: error.localizedDescription, actionTitles: ["OK"], actions: [nil])
        })
    }
}

//MARK: TABLEVIEW DELEGATE AND DATA SOURCE
extension UsersListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Fetch all users from the CoreData
        let users = self.fetchUsers()
        
        return users.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userListTableView.dequeueReusableCell(withIdentifier: Identifiers.CellIDs.userListCellId) as! UserListTableViewCell
        
        //Fetch all users from the CoreData
        let users = self.fetchUsers()
        
        if users.count > 0 {
            let userName = users[indexPath.row].userName
            let email = users[indexPath.row].email
            
        }
        
//        if let users = users {
//            if let profileImage = users[indexPath.row].profile_image {
//                cell.profileImageView.sd_setImage(with: URL(string: profileImage), placeholderImage: UIImage(named: Identifiers.AssetIds.user_placeholder))
//            } else {
//                cell.profileImageView.image = UIImage(named: Identifiers.AssetIds.user_placeholder)
//            }
//
//            if let name = users[indexPath.row].name {
//                cell.nameLabel.text = name
//            } else {
//                cell.nameLabel.text = "Name not available"
//            }
//
//            if let companyName = users[indexPath.row].company?.name {
//                cell.companyLabel.text = companyName
//            } else {
//                cell.companyLabel.text = "Company name not available"
//            }
//        } else {
//            cell.profileImageView.image = UIImage(named: Identifiers.AssetIds.user_placeholder)
//            cell.nameLabel.text = "Name not available"
//            cell.companyLabel.text = "Company name not available"
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did select tablevew row at index: \(indexPath)")
        guard let users = users else { return }
        print("Selected item: \(users[indexPath.row])")
    }
}

//MARK: CoreData helper methods
extension UsersListViewController {
    func fetchUsers() -> [Users] {
        let allUsers = DatabaseController.getAllUsers()
        return allUsers
    }
}
