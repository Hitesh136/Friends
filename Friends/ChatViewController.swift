//
//  ViewController.swift
//  Friends
//
//  Created by Hitesh  Agarwal on 28/11/19.
//  Copyright © 2019 Hitesh  Agarwal. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "ReceivedMessageTableViewCell", bundle: nil), forCellReuseIdentifier: "ReceivedMessageTableViewCell")
            tableView.register(UINib(nibName: "SendedMessageTableViewCell", bundle: nil), forCellReuseIdentifier: "SendedMessageTableViewCell")
        }
    }
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    var tapGesture: UITapGestureRecognizer?
    
    var messages = [Message]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        messages = [
            Message(text: "sdfhasdjkflhasdfdfaskdfhasj", messageType: .sendedText),
            Message(text: "Hfsadf", messageType: .receivedText),
            Message(text: "sdfhasdjkflhasdfdfaskdfhasj khf jkasdhf kjasdfh jkasdhfjkasdlh jklasdh jkasdhfjkasdhasdjk lfadskjfh jkasdhf jkasdlf jlasdhf f", messageType: .sendedText),
            Message(text: "Hfsadf sakdfh jkasdhf kjasdlhf kjlasdfh kjlahdsfjkl asdjashkfjkasdlhfjk sadlfhjkl asdfhjkl ashdfajkl sdfh jkasdh asdhfjk asdldfh kjlakladjsafhlsddhlsf ", messageType: .receivedText),
            Message(text: "sdfhasdjkflhasdfdfaskdfhasj aksjdfhjakshdf jkas", messageType: .sendedText),
            Message(text: "Hfsadf", messageType: .receivedText),
            Message(text: "kjfsahdflkj", messageType: .sendedText),
            Message(text: "Hfsadf", messageType: .receivedText),
            Message(text: "sdfhasdjkflhasdfdfaskdfhasj jakfdlhaskj jkash jkaslhf kljashf ", messageType: .sendedText),
            Message(text: "Hfsadf", messageType: .receivedText)
        ]
        
        messageTextView.addObserver(self, forKeyPath: #keyPath(UITextView.contentSize), options: [.new, .old], context: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func actionSend(_ sender: Any) {
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
                tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionTapGesture))
                self.view.addGestureRecognizer(tapGesture!)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
            if tapGesture != nil {
                self.view.removeGestureRecognizer(tapGesture!)
            }
        }
    }
    
    @objc func actionTapGesture() {
        messageTextView.resignFirstResponder()
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        
        if let textView = object as? UITextView {
            let newContentSize = textView.contentSize.height
            if newContentSize < 100 {
                textViewHeightConstraint.constant = newContentSize
                textView.isScrollEnabled = true
            } else {
                textViewHeightConstraint.constant = 100
                textView.isScrollEnabled = true
            }
        }
    }
    
    deinit {
        messageTextView.removeObserver(self, forKeyPath: #keyPath(UITextView.contentSize))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if 
    }
}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        switch message.messageType {
        case .receivedText:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReceivedMessageTableViewCell", for: indexPath) as! ReceivedMessageTableViewCell
            cell.configueCell(message: message.text)
            return cell
        case .sendedText:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SendedMessageTableViewCell", for: indexPath) as! SendedMessageTableViewCell
            cell.configueCell(message: message.text)
            return cell
        }
    }
    
    
}
