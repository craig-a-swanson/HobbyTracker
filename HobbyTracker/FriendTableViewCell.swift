//
//  FriendTableViewCell.swift
//  HobbyTracker
//
//  Created by Craig Swanson on 9/25/19.
//  Copyright © 2019 Craig Swanson. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hometownLabel: UILabel!
    @IBOutlet weak var hobbyCountLabel: UILabel!
    
    var friend: Friend? {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        guard let friend = friend else { return }
        
        nameLabel.text = friend.name
        hometownLabel.text = friend.hometown
        hobbyCountLabel.text = "\(friend.hobbies.count) Hobbies"
    }


}
