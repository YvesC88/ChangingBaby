//
//  SignUpViewController.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 07/11/2022.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    
    let userService = UserService()
    var delegate: SelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sheetPresentationController?.detents = [.medium()]
        self.sheetPresentationController?.prefersGrabberVisible = true
        
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        let textField = [userNameTextField, emailTextField, passwordTextField]
        for field in textField {
            self.dismissKeyboard(sender, textField: field!)
        }
    }
    
    @IBAction func signUpTapped() {
        userService.createUser(name: userNameTextField.text!, mail: emailTextField.text!, password: passwordTextField.text!) { error in
            guard error != nil else {
                self.delegate?.didFinishAction()
                return
            }
            self.presentAlert(title: "Erreur", message: error ?? "")
        }
    }
}
