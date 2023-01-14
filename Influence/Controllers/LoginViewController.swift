//
//  LoginViewController.swift
//  Influence
//
//  Created by AMOO OLALEKAN on 08/01/2023.
//

import UIKit
import Firebase

class LoginViewController: UIViewController{
        
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginActivityIndicator: UIActivityIndicatorView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stopLoading(activityIndicatorView: loginActivityIndicator)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextField?.text, let password = passwordTextField?.text{
            startLoading(activityIndicatorView: loginActivityIndicator)
            print("\(email) and \(password)")
            signIn(withEmail: email, password: password)
        } else{
            showDismissableAlert(with: "Plaese fill all fields", from: self)
        }
    }
    
    func signIn(withEmail emal:String, password: String) {
        Auth.auth().signIn(withEmail: emal, password: password) { authResult, error in
            if let e = error {
                print(e.localizedDescription)
                DispatchQueue.main.async {
                    stopLoading(activityIndicatorView: self.loginActivityIndicator)
                    showDismissableActionSheet(with: e.localizedDescription, from: self)
                }
                return
            }
            
            self.performSegue(withIdentifier: k.loginSegue, sender: self)
        }
    }
    
}
