//
//  WellcomeViewController.swift
//  Influence
//
//  Created by AMOO OLALEKAN on 08/01/2023.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class RegisterViewController: UIViewController{
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var insagramHandleTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var registerActivityIndicator: UIActivityIndicatorView!
    
    let db = Firestore.firestore()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stopLoading(activityIndicatorView: registerActivityIndicator)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextField?.text,
           let password = passwordTextField?.text,
           let instaHandle = insagramHandleTextField?.text{
            if !isValidHandle(instaHandle: instaHandle) {
                showDismissableAlert(with: "Invalid instagram handle", from: self)
                return
            }
            startLoading(activityIndicatorView: registerActivityIndicator)

            registerUser(email: email, instaHandle: instaHandle, password: password)
            print("\(email), \(instaHandle) and \(password)")
        }else{
            showDismissableAlert(with: "Please fill all fields", from: self)
        }
    }
    
    func registerUser(email : String, instaHandle: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print(e.localizedDescription)
                DispatchQueue.main.async {
                    showDismissableAlert(with: e.localizedDescription, from: self)
                    stopLoading(activityIndicatorView: self.registerActivityIndicator)
                }
                return
            }
            
            if let uid = authResult?.user.uid{
                let usr = User(userId: uid, email: email, instaHandle: instaHandle)
//                let docRef = self.db.document("\(k.col.userCollection)/\(uid)")
                do{
                    try FirebaseRef.getUserReference(userId: uid).setData(from: usr)
                    stopLoading(activityIndicatorView: self.registerActivityIndicator)
                    self.performSegue(withIdentifier: k.registerSegue, sender: self)
                } catch let error{
                    stopLoading(activityIndicatorView: self.registerActivityIndicator)
                    showDismissableAlert(with: error.localizedDescription, from: self)
                }
            }
            
        }
    }
       
}
