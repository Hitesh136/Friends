//
//  ViewController.swift
//  Friends
//
//  Created by Hitesh  Agarwal on 28/11/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import UIKit
import MessageKit

class ChatViewController: MessagesViewController {

	let sender = Sender(id: "any_unique_id", displayName: "Steven")
	let messages: [MessageType] = []
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		messagesCollectionView.messagesDataSource = self
		messagesCollectionView.messagesLayoutDelegate = self
		messagesCollectionView.messagesDisplayDelegate = self
	}
}


extension ChatViewController: MessagesDataSource {	
	
	func currentSender() -> SenderType {
		return Sender(id: "any_unique_id", displayName: "Steven")
	}
	
	func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
		return messages.count
	}
	
	func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
		return messages[indexPath.section]
	}
}

extension ChatViewController: MessagesDisplayDelegate, MessagesLayoutDelegate {
	
}

