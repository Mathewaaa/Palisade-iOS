//
//  FeedViewController.swift
//  Palisade
//
//  Created by Mathew Xie on 12/15/22.
//

import FirebaseDatabase
import UIKit

class FeedViewController: UIViewController {
    
    private let database = Database.database().reference()
    
    @IBOutlet weak var titleButton: UIButton!
    private var category = "sports" // default is sports
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleButton()
        getMessages()
    }
    
    private func getMessages() {
        database.child("palisade").child(category).observe(DataEventType.value, with: {
            snapshot in
            let value = snapshot.value as? NSDictionary
            print(value)
        })
    }
    
    private func setupTitleButton() {
        let titleCategory = UIMenu(title: "Choose Category", children: [
            UIAction(title: "Sports") {
                action in
                self.category = "sports"
            },
            UIAction(title: "Nature") {
                action in
                self.category = "nature"
            },
            UIAction(title: "Art") {
                action in
                self.category = "art"
            },
            UIAction(title: "Dating") {
                action in
                self.category = "dating"
            },
            UIAction(title: "Gaming") {
                action in
                self.category = "gaming"
            },
            UIAction(title: "Food") {
                action in
                self.category = "food"
            },
            UIAction(title: "Feelings") {
                action in
                self.category = "feelings"
            },
            UIAction(title: "Work") {
                action in
                self.category = "work"
            }
        ])
        
        titleButton.menu = titleCategory
    }
}
