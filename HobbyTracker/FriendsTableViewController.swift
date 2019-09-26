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
        
        friends.append(Friend(name: "Person A", hometown: "Los Angeles", hobbies: ["A", "B"]))
        friends.append(Friend(name: "Person B", hometown: "San Diego", hobbies: ["A", "C"]))
        friends.append(Friend(name: "Person C", hometown: "Minneapolis", hobbies: ["A", "C"]))
        friends.append(Friend(name: "Person D", hometown: "Seattle", hobbies: ["A", "E"]))
        friends.append(Friend(name: "Person E", hometown: "Los Angeles", hobbies: ["A", "F"]))
        // Do any additional setup after loading the view.
    }


}

extension FriendsTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as? FriendTableViewCell else { fatalError() }
        
        let friend = friends[indexPath.row]
        cell.friend = friend
        
        return cell
    }
}
