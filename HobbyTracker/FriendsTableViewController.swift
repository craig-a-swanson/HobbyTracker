//
//  FriendsTableViewController.swift
//  HobbyTracker
//
//  Created by Craig Swanson on 9/19/19.
//  Copyright © 2019 Craig Swanson. All rights reserved.
//

import UIKit

class FriendsTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var friends: [Friend] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddFriendModalSegue" {
            guard let addFriendVC = segue.destination as? AddFriendViewController else { fatalError() }
            
            addFriendVC.delegate = self
        }
    }

}

// MARK: - Table View Data Source
extension FriendsTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendTableViewCell else { fatalError() }
        
        let friend = friends[indexPath.row]
        cell.friend = friend
        
        return cell
    }
}

// MARK: - Add Friend Delegate

extension FriendsTableViewController: AddFriendDelegate {
    func friendWasCreated(_ friend: Friend) {
        friends.append(friend)
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
}
