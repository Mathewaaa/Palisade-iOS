//
//  PostViewController.swift
//  Palisade
//
//  Created by Mathew Xie on 12/15/22.
//

import FirebaseDatabase
import UIKit

class PostViewController: UIViewController {

    private let database = Database.database().reference()
    private let uuid = UserDefaults.standard.string(forKey: "uuid")!
    private var category = "sports" // sports is default
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCategoryMenu()
        postButton.isEnabled = false
        postButton.addTarget(self, action: #selector(createPost), for: .touchDown)
        textField.addTarget(self, action: #selector(updateButtonVisibility), for: .editingChanged)
    }
    
    @objc private func updateButtonVisibility() {
        if !(textField.text ?? "").trimmingCharacters(in: .whitespaces).isEmpty {
            postButton.isEnabled = true
        }
        else {
            postButton.isEnabled = false
        }
    }
    
    @objc private func createPost() {
        let object: [String: String] = [
                    "user": uuid,
                    "message": textField.text ?? "",
                ]

        database.child("palisade").child(category).child(String(Int64((NSDate().timeIntervalSince1970 * 1000.0).rounded()))).setValue(object)
        
        
        // after user presses button, reset text field
        textField.text = ""
    }
    
    private func setupCategoryMenu() {
        let categoryMenu = UIMenu(title: "Choose Category", children: [
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
        
        categoryButton.menu = categoryMenu
    }
    
}
