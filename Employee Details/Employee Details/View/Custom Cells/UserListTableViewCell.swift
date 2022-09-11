//
//  UserListTableViewCell.swift
//  Employee Details
//
//  Created by Sreejesh Krishnan on 11/09/22.
//

import UIKit

class UserListTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    fileprivate func setupUI() {
        self.contentView.backgroundColor = .bgLightColor
        self.profileImageView.setRounded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
