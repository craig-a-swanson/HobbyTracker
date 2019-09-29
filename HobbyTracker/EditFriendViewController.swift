//
//  AddFriendViewController.swift
//  HobbyTracker
//
//  Created by Craig Swanson on 9/25/19.
//  Copyright © 2019 Craig Swanson. All rights reserved.
//

import UIKit

protocol EditFriendDelegate {
    func friendWasCreated(_ friend: Friend)
    func friend(_ oldFriend: Friend, wasUpdated newFriend: Friend)
}

class EditFriendViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var hometownTextField: UITextField!
    @IBOutlet weak var hobby1TextField: UITextField!
    @IBOutlet weak var hobby2TextField: UITextField!
    @IBOutlet weak var hobby3TextField: UITextField!
    
    var delegate: EditFriendDelegate?
    
    // added code to edit old friend
    var oldFriend: Friend?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()

        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        guard let oldFriend = oldFriend else { return }
        
        nameTextField.text = oldFriend.name
        hometownTextField.text = oldFriend.hometown
        
        if oldFriend.hobbies.count > 0 {
            hobby1TextField.text = oldFriend.hobbies[0]
            
            if oldFriend.hobbies.count > 1 {
                hobby2TextField.text = oldFriend.hobbies[1]
                
                if oldFriend.hobbies.count > 2 {
                    hobby3TextField.text = oldFriend.hobbies[2]
                }
            }
        }
    }
    
    @IBAction func cancelOperation(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveFriend(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text, !name.isEmpty,
            let hometown = hometownTextField.text, !hometown.isEmpty else {
                return
        }
        
        var friend = Friend(name: name, hometown: hometown, hobbies: [])
        
        if let hobby1 = hobby1TextField.text, !hobby1.isEmpty {
            friend.hobbies.append(hobby1)
        }
        if let hobby2 = hobby2TextField.text, !hobby2.isEmpty {
            friend.hobbies.append(hobby2)
        }
        if let hobby3 = hobby3TextField.text, !hobby3.isEmpty {
            friend.hobbies.append(hobby3)
        }
        
        // this code checks to see if the update was on an existing friend
        // if so, it runs the wasUpdated delegate protocol
        // if not (friend is new entry) it runs the wasCreated delegate protocol
        if let oldFriend = oldFriend {
            delegate?.friend(oldFriend, wasUpdated: friend)
        } else {
            delegate?.friendWasCreated(friend)
        }
    }
    
}
