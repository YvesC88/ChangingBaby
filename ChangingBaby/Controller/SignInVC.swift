//
//  SignInVC.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 07/11/2022.
//

import UIKit

class SignInVC: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    let userService = UserService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sheetPresentationController?.detents = [.medium()]
        setupUIButton(button: signInButton)
    }
    
    @IBAction func loginButtonTapped() {
        userService.signIn(mail: emailTextField.text!, password: passwordTextField.text!) { error in
            guard error != nil else {
                self.dismiss(animated: true) {
                    guard let navController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController else { return }
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "MapVC") as! MapVC
                    navController.setViewControllers([vc], animated: true)
                }
                return
            }
            self.presentAlert(title: "Erreur", message: error ?? "")
        }
    }
    
    @IBAction func forgetPassword() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ForgetPwdVC") as? ForgetPwdVC else { return }
        present(vc, animated: true)
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        let textField = [emailTextField, passwordTextField]
        for field in textField {
            self.dismissKeyboard(sender, textField: field!)
        }
    }
    
    func setupUIButton(button: UIButton) {
        button.layer.borderColor = UIColor.tintColor.cgColor
        button.layer.borderWidth = 2
    }
}


class ForgetPwdVC: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    let userService = UserService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sheetPresentationController?.detents = [.medium()]
    }
    @IBAction func getNewPwd() {
        userService.forgetPwd(userMail: (emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!) { error in
            guard error != nil else {
                self.presentAlert(title: "Succès", message: "La demande de réinitialisation du mot de passe a été envoyé par email.")
                return
            }
            self.presentAlert(title: "Erreur", message: error ?? "")
        }
    }
    
    @IBAction func dismissForgetPwdViewController() {
        dismiss(animated: true)
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.dismissKeyboard(sender, textField: emailTextField)
    }
}
