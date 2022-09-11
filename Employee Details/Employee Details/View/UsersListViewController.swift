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
    var userDetailsVM: EmployeeListViewModel?
    var users: [EmployeeListModel]?
    
    //View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        userDetailsVM = EmployeeListViewModel()
        self.userListTableView.backgroundColor = .bgLightColor
        registerCustomCell()
        checkForStoredData()
    }
    
    //Methods
    fileprivate func checkForStoredData() {
        //If stored data in nil
        let database = DatabaseController.shared
        let usersList = database.fetch(Users.self)
        if usersList.count > 0 {
            //Data already exists in the CoreData memory
            //No need to call the webservice
            self.reloadTableView()
        } else {
            //No data stored
            //Initiate API call
            self.getDataFromTheServer()
        }
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
        userDetailsVM?.fetchUserDetails(urlString: API.baseUrl, completion: {
            //Stop activity indicator
            self.stopActivityIndicator()
            
            let database = DatabaseController.self
            database.shared.save()
            
            //Reload tableview
            self.reloadTableView()
        })
    }
}

//MARK: TABLEVIEW DELEGATE AND DATA SOURCE
extension UsersListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Fetch all users from the CoreData
        let users = self.fetchUsers()
        
        return users.count - 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userListTableView.dequeueReusableCell(withIdentifier: Identifiers.CellIDs.userListCellId) as! UserListTableViewCell
        
        //Fetch all users from the CoreData
        let users = self.fetchUsers()
        let companies = self.fetchCompanies()
        
        if users.count > 0 {
            if let name = users[indexPath.row].name {
                cell.nameLabel.text = name
            } else {
                cell.nameLabel.text = "Name not found"
            }
            
            if let profileImage = users[indexPath.row].profileImage {
                cell.profileImageView.sd_setImage(with: URL(string: profileImage), placeholderImage: UIImage(named: Identifiers.AssetIds.user_placeholder))
            } else {
                cell.profileImageView.image = UIImage(named: Identifiers.AssetIds.user_placeholder)
            }
        }
        
        if companies.count > 0 {
            if let companyName = companies[indexPath.row].name {
                cell.companyLabel.text = companyName
            } else {
                cell.companyLabel.text = "Not found"
            }
        }
        
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
        let allUsers = DatabaseController.shared.fetch(Users.self)
        return allUsers
    }
    
    func fetchCompanies() -> [Company] {
        let allCompanies = DatabaseController.shared.fetch(Company.self)
        return allCompanies
    }
}

