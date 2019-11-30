//
//  ReceivedMessageTableViewCell.swift
//  Friends
//
//  Created by Hitesh  Agarwal on 29/11/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import UIKit

class ReceivedMessageTableViewCell: UITableViewCell {

	@IBOutlet weak var messageLabel: UILabel!
	@IBOutlet weak var labelBackgroundView: UIView!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
	}
	
	func configureView() {
        labelBackgroundView.layer.cornerRadius = 5
        labelBackgroundView.clipsToBounds = true
	}
   
	func configueCell(message: String) {
		self.messageLabel.text = message
	}
}
