//
//  FeedViewController.swift
//  Palisade
//
//  Created by Mathew Xie on 12/15/22.
//

import FirebaseDatabase
import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let database = Database.database().reference()
    
    @IBOutlet weak var tableView: UITableView!
    var posts: [Post] = []
    @IBOutlet weak var titleButton: UIButton!
    private var category = "sports" // default is sports
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "postCell")
        view.addSubview(tableView)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        setupTitleButton()
        getMessages()
    }
    
    private func getMessages() {
        posts = []
        database.child("palisade").child(category).observe(DataEventType.value, with: {
            snapshot in
            if let d = snapshot.value as? [String: Any] {
                for value in d.keys {
                    if let dict = d[value] as? [String: Any] {
                        let date = Date(timeIntervalSince1970: (Double(value) ?? 0) / 1000.0)
                        let dateFormatter = DateFormatter()
                        dateFormatter.timeZone = TimeZone(abbreviation: "PDT")
                        dateFormatter.locale = NSLocale.current
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                        let strDate = dateFormatter.string(from: date)
                        let user = dict["user"] as? String ?? "null"
                        let replies = dict["replies"] as? [String: Any] ?? [:]
                        let message = dict["message"] as? String ?? "null"
                        if (message.count > 0) { // hardcode to get rid of empty messages
                            self.posts.append(Post(user: user, message: message, timestamp: strDate, replies: replies))
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            
            
        })
    }
    
    private func setupTitleButton() {
        let titleCategory = UIMenu(title: "Choose Category", children: [
            UIAction(title: "Sports") {
                action in
                self.category = "sports"
                self.getMessages()
            },
            UIAction(title: "Nature") {
                action in
                self.category = "nature"
                self.getMessages()
            },
            UIAction(title: "Art") {
                action in
                self.category = "art"
                self.getMessages()
            },
            UIAction(title: "Dating") {
                action in
                self.category = "dating"
                self.getMessages()
            },
            UIAction(title: "Gaming") {
                action in
                self.category = "gaming"
                self.getMessages()
            },
            UIAction(title: "Food") {
                action in
                self.category = "food"
                self.getMessages()
            },
            UIAction(title: "Feelings") {
                action in
                self.category = "feelings"
                self.getMessages()
            },
            UIAction(title: "Work") {
                action in
                self.category = "work"
                self.getMessages()
            }
        ])
        
        titleButton.menu = titleCategory
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        cell.set(post: posts[indexPath.row])
        return cell
    }
}
