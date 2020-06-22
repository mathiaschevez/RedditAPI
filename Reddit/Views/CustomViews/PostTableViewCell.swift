//
//  PostTableViewCell.swift
//  Reddit
//
//  Created by Mathias on 6/17/20.
//  Copyright © 2020 Mathias Chevez. All rights reserved.
//

import UIKit

protocol PresentErrorToUserDelegate: class {
    func presentErrorToUser(error: LocalizedError)
}

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var upvoteLabel: UILabel!
    
    var post: Post? {
        didSet{
            updateViews()
        }
    }
    
    weak var delegate: PresentErrorToUserDelegate?
    
    func updateViews() {
        guard let post = post else {return}
        titleLabel.text = post.title
        upvoteLabel.text = "Upvotes: \(post.ups)"
        thumbnailImageView.image = nil
        
        PostController.fetchThumbnailFor(post: post) { (result) in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.delegate?.presentErrorToUser(error: error)
                }
                print(error.localizedDescription)
            }
        }
    }
}
