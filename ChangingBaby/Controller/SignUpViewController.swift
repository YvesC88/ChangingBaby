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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sheetPresentationController?.detents = [.medium()]
        
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
                self.dismiss(animated: true) {
                    guard let navController = UIApplication.shared.windows.first!.rootViewController as? UINavigationController else { return }
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                    navController.setViewControllers([vc], animated: true)
                }
                self.presentAlert(title: "Succès", message: "Compte créé avec succès !")
                return
            }
            self.presentAlert(title: "Erreur", message: error ?? "")
        }
    }
}
