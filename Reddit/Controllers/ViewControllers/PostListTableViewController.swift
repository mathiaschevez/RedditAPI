//
//  PostListTableViewController.swift
//  Reddit
//
//  Created by Mathias on 6/17/20.
//  Copyright © 2020 Mathias Chevez. All rights reserved.
//

import UIKit

class PostListTableViewController: UITableViewController {
    
    var posts: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
    }
    
    func fetchPosts() {
        PostController.fetchPosts { (result) in
            switch result {
            case .success(let posts):
                self.posts = posts
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else {return UITableViewCell()}
        let post = posts[indexPath.row]
        
        cell.post = post
        cell.delegate = self

        return cell
    }
}

extension PostListTableViewController: PresentErrorToUserDelegate {
    
    func presentErrorToUser(error: LocalizedError) {
        self.presentErrorToUser(error: error)
    }
}
