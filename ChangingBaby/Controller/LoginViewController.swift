//
//  LoginViewController.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 07/11/2022.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    let userService = UserService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sheetPresentationController?.detents = [.medium()]
        setupUIButton(button: loginButton)
        // vérifier si une erreur s'est produite lors du login
    }
    
    @IBAction func loginButtonTapped() {
        userService.signIn(mail: emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines),
                           password: passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)) { error in
            if error != "" {
                self.errorLabel.isHidden = false
                self.errorLabel.text = error
            } else {
                self.dismiss(animated: true)
            }
        }
    }
    
    @IBAction func forgotPassword() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ForgetPasswordViewController") as? ForgetPasswordViewController else { return }
        present(vc, animated: true)
    }
    
    func setupUIButton(button: UIButton) {
        button.layer.borderColor = UIColor.tintColor.cgColor
        button.layer.borderWidth = 2
    }
}

//emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)


class ForgetPasswordViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    let userService = UserService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sheetPresentationController?.detents = [.medium()]
    }
    @IBAction func getNewPwd() {
        userService.forgetPwd(userMail: (emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!) { error in
            var err = ""
            if err != error.localizedDescription {
                self.errorLabel.isHidden = false
                self.errorLabel.text = err
            } else {
                self.errorLabel.textColor = UIColor.tintColor
                self.errorLabel.text = "Si cet email existe, vous receverez un mail !"
                
            }
        }
    }
    
    @IBAction func dismissForgetPwdViewController() {
        dismiss(animated: true)
    }
}
