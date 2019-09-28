//
//  FriendDetailViewController.swift
//  HobbyTracker
//
//  Created by Craig Swanson on 9/25/19.
//  Copyright © 2019 Craig Swanson. All rights reserved.
//

import UIKit

class FriendDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hometownLabel: UILabel!
    @IBOutlet weak var hobbyListTextView: UITextView!
    
    var friend: Friend? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    

    private func updateViews() {
        guard let friend = friend, isViewLoaded else { return }
        
        nameLabel.text = friend.name
        hometownLabel.text = friend.hometown
        
        var hobbyText = ""
        for hobby in friend.hobbies {
            hobbyText += "• \(hobby)\n"
        }
        hobbyListTextView.text = hobbyText
    }
}
