//
//  ForgetPwdViewController.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 05/12/2022.
//

import UIKit

class ForgetPwdViewController: UIViewController {
    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    
    let userService = UserService(wrapper: FirebaseWrapper())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIButton(button: [validateButton])
    }
    
    @IBAction func getNewPwd() {
        if let email = emailTextField.text {
            userService.forgetPwd(userMail: email) { error in
                guard error != nil else {
                    self.presentAlert(title: "Succès", message: "La demande de réinitialisation du mot de passe a été envoyé par email.")
                    return
                }
                self.presentAlert(title: "Oups", message: error ?? "")
            }
        }
    }
    
    @IBAction func dismissForgetPwdViewController() {
        dismiss(animated: true)
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.dismissKeyboard(sender, textField: emailTextField)
    }
}
