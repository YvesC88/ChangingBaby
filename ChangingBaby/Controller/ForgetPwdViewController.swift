//
//  ForgetPwdViewController.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 05/12/2022.
//

import UIKit

class ForgetPwdViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    
    let userService = UserService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sheetPresentationController?.detents = [.medium()]
        self.sheetPresentationController?.prefersGrabberVisible = true
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
