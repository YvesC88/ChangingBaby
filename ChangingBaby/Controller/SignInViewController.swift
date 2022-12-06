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
    
    let userService = UserService()
    var delegate: SelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sheetPresentationController?.detents = [.medium()]
        self.sheetPresentationController?.prefersGrabberVisible = true
        self.setupUIButton(button: signInButton)
        
    }
    
    @IBAction func loginButtonTapped() {
        userService.signIn(mail: emailTextField.text!, password: passwordTextField.text!) { error in
            guard error != nil else {
                self.delegate?.didFinishAction()
                return
            }
            self.presentAlert(title: "Erreur", message: error ?? "")
        }
    }
    
    @IBAction func forgetPassword() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ForgetPwdViewController") as? ForgetPwdViewController else { return }
        present(vc, animated: true)
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        let textField = [emailTextField, passwordTextField]
        for field in textField {
            self.dismissKeyboard(sender, textField: field!)
        }
    }
}
