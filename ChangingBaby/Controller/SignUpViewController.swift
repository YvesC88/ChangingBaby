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
        userService.createUser(name: userNameTextField.text!, mail: emailTextField.text!, password: passwordTextField.text!) { result, error  in
            guard error != nil else {
                if let navController = self.navigationController {
                    navController.popViewController(animated: true)
                }
                return
            }
            self.presentAlert(title: "Erreur", message: error ?? "")
        }
    }
}
