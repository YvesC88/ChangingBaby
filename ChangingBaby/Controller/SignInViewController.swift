//
//  SignInViewController.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 07/11/2022.
//

import UIKit

class SignInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    let userService = UserService(wrapper: FirebaseWrapper())
    var delegate: SelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIButton(buttons: [signInButton])
    }
    
    // call signIn func with error's checking
    @IBAction func loginButtonTapped() {
        userService.signIn(mail: emailTextField.text!, password: passwordTextField.text!) { result, error  in
            guard error != nil else {
                self.delegate?.didFinishAction()
                return
            }
            self.presentAlert(title: "Erreur", message: error ?? "")
        }
    }
    
    // to go ForgetPwdViewController
    @IBAction func forgetPassword() {
        self.presentVC(with: "ForgetPwdViewController")
    }
    
    // to dismiss Keyboard with gesture
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        let textField = [emailTextField, passwordTextField]
        for field in textField {
            self.dismissKeyboard(sender, textField: field!)
        }
    }
    
    // to dismiss SignInViewController
    @IBAction func dismissSignInViewController() {
        dismiss(animated: true)
    }
}
