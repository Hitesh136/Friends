//
//  SendedMessageTableViewCell.swift
//  Friends
//
//  Created by Hitesh  Agarwal on 29/11/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import UIKit

class SendedMessageTableViewCell: UITableViewCell {

	@IBOutlet weak var messageLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	func configueCell(message: String) {
		self.messageLabel.text = message
	}
}
