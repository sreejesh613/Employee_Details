//
//  UserDetailsViewController.swift
//  Employee Details
//
//  Created by Sreejesh Krishnan on 11/09/22.
//

import UIKit
import SDWebImage

class UserDetailsViewController: UIViewController {

    //MARK: OUTLETS
    @IBOutlet weak var detailTableView: UITableView!
    
    //MARK: PROPERTIES
    var user: Users?
    var address: Address?
    var company: Company?
    var geo: Geo?
    
    //MARK: VIEW LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCustomCells()
        reloadTableView()
    }
    
    fileprivate func reloadTableView() {
        DispatchQueue.main.async {
            self.detailTableView.reloadData()
        }
    }
    
    fileprivate func registerCustomCells() {
        let profileNib = UINib(nibName: Identifiers.NibNames.profileImageNib, bundle: nil)
        detailTableView.register(profileNib, forCellReuseIdentifier: Identifiers.CellIDs.profileImageCell)
        
        let normalNib = UINib(nibName: Identifiers.NibNames.userDetailsNib, bundle: nil)
        detailTableView.register(normalNib, forCellReuseIdentifier: Identifiers.CellIDs.userDetailCellId)
        
        let textViewNib = UINib(nibName: Identifiers.NibNames.detailTextViewNib, bundle: nil)
        detailTableView.register(textViewNib, forCellReuseIdentifier: Identifiers.CellIDs.detailTextViewCell)
    }
}

//MARK: TABLEVIEW DELEGATE AND DATASOURCE
extension UserDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0,4,7:
            //Profile image
            //Address
            //Company details
            return 160
        case 1,2,3,5,6:
            return 80
        default:
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let imageCell = detailTableView.dequeueReusableCell(withIdentifier: Identifiers.CellIDs.profileImageCell) as! ProfileImageTableViewCell
        let normalContentCell = detailTableView.dequeueReusableCell(withIdentifier: Identifiers.CellIDs.userDetailCellId) as! UserDetailTableViewCell
        let textViewCell = detailTableView.dequeueReusableCell(withIdentifier: Identifiers.CellIDs.detailTextViewCell) as! DetailTextViewTableViewCell
        
        switch indexPath.row {
        case 0:
            //Profile image
            if let profileImage = user?.profileImage {
                imageCell.profileImageView.sd_setImage(with: URL(string: profileImage), placeholderImage: UIImage(named: Identifiers.AssetIds.user_placeholder))
            } else {
                imageCell.profileImageView.image = UIImage(named: Identifiers.AssetIds.user_placeholder)
            }
            return imageCell
        case 1:
            //Name
            normalContentCell.titleLabel.text = StringConstants.name
            if let name = user?.name {
                normalContentCell.contentLabel.text = name
            } else {
                normalContentCell.contentLabel.text = StringConstants.notFound
            }
            return normalContentCell
        case 2:
            //UserName
            normalContentCell.titleLabel.text = StringConstants.userName

            if let userName = user?.userName {
                normalContentCell.contentLabel.text = userName
            } else {
                normalContentCell.contentLabel.text = StringConstants.notFound
            }
            return normalContentCell
        case 3:
            //Email
            normalContentCell.titleLabel.text = StringConstants.email

            if let emailAddress = user?.email {
                normalContentCell.contentLabel.text = emailAddress
            } else {
                normalContentCell.contentLabel.text = StringConstants.notFound
            }
            return normalContentCell
        case 4:
            //Address
            textViewCell.titleLabel.text = StringConstants.address

            if let address = address {
                let city = address.city ?? ""
                let street = address.street ?? ""
                let zip = address.zip ?? ""
                
                let fullAddress = "\(city) \n \(street) \n \(zip)"
                
                textViewCell.detailTextView.text = fullAddress
            } else {
                textViewCell.detailTextView.text = StringConstants.addNotAvailable
            }
            return textViewCell
        case 5:
            //Phone
            normalContentCell.titleLabel.text = StringConstants.phone
            if let user = user {
                normalContentCell.contentLabel.text = user.phone
            } else {
                normalContentCell.contentLabel.text = StringConstants.notFound
            }
            return normalContentCell
        case 6:
            //Website
            normalContentCell.titleLabel.text = StringConstants.website
            if let user = user {
                normalContentCell.contentLabel.text = user.website
            } else {
                normalContentCell.contentLabel.text = StringConstants.notFound
            }
            return normalContentCell
        case 7:
            //Company
            textViewCell.titleLabel.text = StringConstants.company
            if let company = company {
                let name = company.name ?? ""
                let catchPhrase = company.catchPhrase ?? ""
                let bs = company.bs ?? ""
                
                let fullDetails = "\(name) \n \(catchPhrase) \n \(bs)"
                
                textViewCell.detailTextView.text = fullDetails
            } else {
                normalContentCell.contentLabel.text = StringConstants.notFound
            }
            return textViewCell
            
        default:
            return UITableViewCell()
        }
    }
}
