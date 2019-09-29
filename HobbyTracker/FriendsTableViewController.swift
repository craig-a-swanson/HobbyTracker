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
    var indexPathForTappedAccessoryButton: IndexPath?
    
    // Adding a place to save things.
    // this variable and code is used to save data to the disc
    // returns the URL of where we want to save the storage of our friends.
    var persistentStoreURL: URL! {
        if let documentURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) {
            let persistentStoreURL = documentURL.appendingPathComponent("friendsList.plist")
            return persistentStoreURL
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // this if let is used to load saved data from the disc
        if let data = try? Data(contentsOf: persistentStoreURL),
            let savedFriends = try? PropertyListDecoder().decode([Friend].self, from: data) {
            friends = savedFriends
        }
    }
    
    // This is part of the save functionality.  Call the function when a friend is created and when a friend is deleted.
    func save() {
        if let data = try? PropertyListEncoder().encode(friends) {
            try? data.write(to: persistentStoreURL)
        }
    }
            
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "AddFriendModalSegue":
            guard let addFriendVC = segue.destination as? EditFriendViewController
                else { fatalError() }
            addFriendVC.delegate = self
            
        case "UpdateFriendModalSegue":
            guard let indexPath = indexPathForTappedAccessoryButton,
                let editFriendVC = segue.destination as? EditFriendViewController else { fatalError() }
            editFriendVC.delegate = self
            editFriendVC.oldFriend = friends[indexPath.row]
            
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

// MARK: Table View Delegate (Swipe to delete)
// this extension is all the code required to add the swipe to delete row functionality

extension FriendsTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        friends.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        save()
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        indexPathForTappedAccessoryButton = indexPath
        performSegue(withIdentifier: "UpdateFriendModalSegue", sender: self)
    }
}

// MARK: - Add Friend Delegate

extension FriendsTableViewController: EditFriendDelegate {
    func friendWasCreated(_ friend: Friend) {
        friends.append(friend)
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
        
        save()
    }
    
    func friend(_ oldFriend: Friend, wasUpdated newFriend: Friend) {
        guard let indexpath = indexPathForTappedAccessoryButton else {
            return
        }
        friends[indexpath.row] = newFriend
        tableView.reloadRows(at: [indexpath], with: .automatic)
        dismiss(animated: true, completion: nil)
        
        save()
    }
    
}
