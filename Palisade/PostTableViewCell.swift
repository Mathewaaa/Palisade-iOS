//
//  PostTableViewCell.swift
//  Palisade
//
//  Created by Mathew Xie on 12/27/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var viewReplies: UIButton!
    @IBOutlet weak var textField: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(post: Post) {
        timeStamp.text = post.timestamp
        textField.text = post.message
    }
    
}
