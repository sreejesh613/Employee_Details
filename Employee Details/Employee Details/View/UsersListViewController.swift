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
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var searchView: UIView!
    
    //Properties
    var userDetailsVM: EmployeeListViewModel?
    let database = DatabaseController.shared
    var textEntered: String? {
        didSet {
            if let text = textEntered {
                self.getFilteredData(item: text)
            }
        }
    }
    
    var usersFetched: [Users]? {
        didSet {
            if let _ = usersFetched {
                self.reloadTableView()
            }
        }
    }
    
    lazy var companiesFetched: [Company]? = {
        let companies = database.fetch(Company.self)
        return companies
    }()
    
    var companyNames: [String] = []
    
    //View life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        userDetailsVM = EmployeeListViewModel()
        setupUI()
        registerCustomCell()
        checkForStoredData()
    }
    
    //Methods
    fileprivate func setupUI() {
        searchField.borderStyle = .none
        self.userListTableView.backgroundColor = .bgLightColor
        self.setBorderForTextField(view: searchView)
    }
    
    fileprivate func checkForStoredData() {
        
        let usersList = database.fetch(Users.self)
        if usersList.count > 0 {
            //Data already exists in the CoreData memory
            //No need to call the webservice
            self.usersFetched = usersList
            self.setupCompanyNames(users: usersList)
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
    
    //MARK: IBACTIONS
    @IBAction func didTapCloseButton(_ sender: UIButton) {
        searchField.text = ""
        searchField.resignFirstResponder()
        
        let users = self.database.fetch(Users.self)
        self.setupCompanyNames(users: users)
        self.usersFetched = users
    }
    
    fileprivate func getFilteredData(item: String) {
        
        var filteredUsers: [Users] = []
        var filteredUserIds: [Int16] = []
        
        guard let usersFetched = usersFetched else { return }
            
            if usersFetched.isEmpty { return }
            
            let filteredArray = usersFetched.compactMap({ $0.name!.lowercased().contains(item) || $0.email!.lowercased().contains(item)})
            var indexArray: [Int] = []
            for each in filteredArray {
                if each {
                    if let index = filteredArray.firstIndex(of: each) {
                        indexArray.append(index)
                    }
                }
            }
            if indexArray.count > 0 {
                for eachIndex in indexArray {
                    let user = usersFetched[eachIndex]
                    filteredUsers.append(user)
                    filteredUserIds.append(user.id)
                }
            }
            self.usersFetched = filteredUsers
            self.setupCompanyNames(users: filteredUsers)
        
    }
}

//MARK: API HANDLING
extension UsersListViewController {

    func getDataFromTheServer() {
        //Show activity indicator
        self.showActivityIndicatorWithText(text: "Getting data from the server..")
        
        //Initiate API call
        userDetailsVM?.fetchUserDetails(urlString: API.baseUrl, completion: { status in
            //Stop activity indicator
            self.stopActivityIndicator()
            
            if status {
                let users = self.database.fetch(Users.self)
                self.setupCompanyNames(users: users)
                self.usersFetched = users
            } else {
                //Status false
                //Show any errors found to the user
            }
        })
    }
    
    func setupCompanyNames(users: [Users]) {
        for eachUser in users {
            let companyName = self.getCompany(for: eachUser.id)?.name ?? StringConstants.notFound
            self.companyNames.append(companyName)
        }
    }
}

//MARK: TABLEVIEW DELEGATE AND DATA SOURCE
extension UsersListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Fetch all users from the CoreData
        
        return usersFetched?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userListTableView.dequeueReusableCell(withIdentifier: Identifiers.CellIDs.userListCellId) as! UserListTableViewCell
        
        //Use the globally stored variables
        guard let users = usersFetched else { return UITableViewCell() }
        
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
            
            cell.companyLabel.text = companyNames[indexPath.row]
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let users = usersFetched,!users.isEmpty else { return }
        
            let selectedId = users[indexPath.row].id
            
            //Get object models for the selected id
            let userModel = self.getUserModel(for: selectedId)
            let addressModel = self.getAddress(for: selectedId)
            let company = self.getCompany(for: selectedId)
            let geoModel = self.getGeo(for: selectedId)
            
            let storyboard = UIStoryboard(name: Identifiers.StoryboardName.userDetails.rawValue, bundle: nil)
            let userDetailsVC = storyboard.instantiateViewController(withIdentifier: Identifiers.ViewControllerName.userDetailsVC) as! UserDetailsViewController
            
            userDetailsVC.user = userModel
            userDetailsVC.address = addressModel
            userDetailsVC.company = company
            userDetailsVC.geo = geoModel
            
            self.navigationController?.pushViewController(userDetailsVC, animated: true)
        
    }
}


//MARK: TEXTFIELD DELEGATES
extension UsersListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let text = textField.text
        if text != "" {
            self.textEntered = text
        }
        textField.resignFirstResponder()
        return true
    }
}

//MARK: CoreData helper methods
extension UsersListViewController {
    
    func fetchUsers() -> [Users] {
        let allUsers = database.fetch(Users.self)
        return allUsers
    }
    
    func fetchCompanies() -> [Company] {
        let allCompanies = database.fetch(Company.self)
        return allCompanies
    }
    
    fileprivate func getUserModel(for id: Int16) -> Users? {
        let users = database.getPredicatedUsers(for: id)
        return users
    }
    
    fileprivate func getAddress(for id: Int16) -> Address? {
        let address = database.getPredicatedAddress(for: id)
        return address
    }
    
    fileprivate func getCompany(for id: Int16) -> Company? {
        let company = database.getPredicatedCompany(for: id)
        return company
    }
    
    fileprivate func getGeo(for id: Int16) -> Geo? {
        let geo = database.getPredicatedGeo(for: id)
        return geo
    }
}
