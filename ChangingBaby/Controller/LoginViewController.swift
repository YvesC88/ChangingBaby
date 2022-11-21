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
    
    private let userService = UserService()
    private let homeViewController = HomeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sheetPresentationController?.detents = [.medium()]
        setupUIButton(button: loginButton)
        // vérifier si une erreur s'est produite lors du login
    }
    
    @IBAction func loginButtonTapped() {
        userService.signIn(mail: emailTextField.text!, password: passwordTextField.text!) { error in
            if error != "" {
                self.errorLabel.isHidden = false
                self.errorLabel.text = error
            } else {
                self.dismiss(animated: true)
            }
        }
    }
    
    private func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    func setupUIButton(button: UIButton) {
        button.layer.borderColor = UIColor.tintColor.cgColor
        button.layer.borderWidth = 2
    }
}


//        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
//            presentAlert(title: "Erreur", message: "Champs manquant !")
//            errorLabel.isHidden = false
//        } else {
//            userService.signIn(mail: emailTextField.text!, password: passwordTextField.text!)
////            presentAlert(title: "Succès !", message: "Connexion réussie")
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let vc = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated:true, completion:nil)
//        }
