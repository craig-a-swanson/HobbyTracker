//
//  AddFriendViewController.swift
//  HobbyTracker
//
//  Created by Craig Swanson on 9/25/19.
//  Copyright © 2019 Craig Swanson. All rights reserved.
//

import UIKit

protocol AddFriendDelegate {
    func friendWasCreated(_ friend: Friend)
}

class AddFriendViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var hometownTextField: UITextField!
    @IBOutlet weak var hobby1TextField: UITextField!
    @IBOutlet weak var hobby2TextField: UITextField!
    @IBOutlet weak var hobby3TextField: UITextField!
    
    var delegate: AddFriendDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        delegate?.friendWasCreated(friend)
    }
    
}
