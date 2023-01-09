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
    
    // call new password func with error's checking
    @IBAction func getNewPwd() {
        userService.forgetPwd(userMail: (emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))!) { error in
            guard error != nil else {
                self.presentAlert(title: "Succès", message: "La demande de réinitialisation du mot de passe a été envoyé par email.")
                return
            }
            self.presentAlert(title: "Erreur", message: error ?? "")
        }
    }
    
    // dismiss forgetPwdViewController
    @IBAction func dismissForgetPwdViewController() {
        dismiss(animated: true)
    }
    
    // dismiss keyboard with gesture
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.dismissKeyboard(sender, textField: emailTextField)
    }
}
