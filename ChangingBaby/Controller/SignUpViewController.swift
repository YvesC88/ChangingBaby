//
//  SignUpViewController.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 07/11/2022.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    
    let userService = UserService(wrapper: FirebaseWrapper())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIButton(button: [signUpButton])
    }
    
    // to dismiss keyboard with a gesture
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        let textField = [userNameTextField, emailTextField, passwordTextField]
        for field in textField {
            self.dismissKeyboard(sender, textField: field!)
        }
    }
    
    // call create func with error's checking
    @IBAction func signUpTapped() {
        if let userName = userNameTextField.text, let email = emailTextField.text, let password = passwordTextField.text {
            if !userName.isEmpty, !email.isEmpty, !password.isEmpty {
                userService.createUser(name: userName, mail: email, password: password) { result, error  in
                    guard error != nil else {
                        if let navController = self.navigationController {
                            navController.popViewController(animated: true)
                        }
                        return
                    }
                    self.presentAlert(title: "Oups", message: error ?? "")
                }
            } else {
                self.presentAlert(title: "Oups", message: "Un champ est manquant.")
            }
        }
    }
}
