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
    
    var persistentStoreURL: URL! {
        if let documentURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) {
            let persistentStoreURL = documentURL.appendingPathComponent("friendsList.plist")
            return persistentStoreURL
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = try? Data(contentsOf: persistentStoreURL),
            let savedFriends = try? PropertyListDecoder().decode([Friend].self, from: data) {
            friends = savedFriends
        }
    }
    
    //func save() {
    //    if let data = try? PropertyListEncoder().encode(friends) {
    //        try? data.write(to: )
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "AddFriendModalSegue":
            guard let addFriendVC = segue.destination as? AddFriendViewController
                else { fatalError() }
            addFriendVC.delegate = self
            
        case "ShowFriendDetailSegue":
            guard let indexPath = tableView.indexPathForSelectedRow,
                let friendDetailVC = segue.destination as?
                FriendDetailViewController else { fatalError() }
            friendDetailVC.friend = friends[indexPath.row]
            
        default:
            fatalError("An unknown segue was encountered: \(segue.identifier ?? "<No ID>")")
        }
        
    
} //ShowFriendDetailSegue

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
        
//        save()
    }
}
