//
//  PostModel.swift
//  Palisade
//
//  Created by Mathew Xie on 12/27/22.
//

import Foundation

class Post {
    var user: String
    var message: String
    var timestamp: String
    var replies: [String: Any]
    
    init(user: String, message: String, timestamp: String, replies: [String: Any]) {
        self.user = user
        self.message = message
        self.timestamp = timestamp
        self.replies = replies
    }
}
