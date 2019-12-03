//
//  UserTableViewCell.swift
//  Friends
//
//  Created by Hitesh Agarwal on 03/12/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailIdLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    func configureView() {
        self.selectionStyle = .none
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
        userImageView.clipsToBounds = true
    }
    
    func bind(withViewModel viewModel: UserViewModel) {
        userNameLabel.text = viewModel.userName
        userEmailIdLabel.text = viewModel.userEmailId
        userImageView.kf.setImage(with: viewModel.userImageURL, placeholder: #imageLiteral(resourceName: "avatarPlaceholder"))
    }
}
