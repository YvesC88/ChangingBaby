//
//  SignUpViewController.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 07/11/2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class SignUpViewController: UIViewController {
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    let userService = UserService()
    let homeViewController = HomeViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sheetPresentationController?.detents = [.medium()]
        
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        userNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        userService.createUser(userName: userNameTextField.text!, mail: emailTextField.text!, password: passwordTextField.text!) { error in
            if error != "" {
                self.errorLabel.isHidden = false
                self.errorLabel.text = error
            } else {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated:true, completion:nil)
            }
        }
    }
    
    private func presentAlert(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}

//        if userNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
//            presentAlert(message: "Champs manquant !")
//            errorLabel.text = UserService.shared.errorMessage
//        } else {
//            UserService.shared.createUser(userName: userNameTextField.text!, mail: emailTextField.text!, password: passwordTextField.text!)
//            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//            let vc = storyBoard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated:true, completion:nil)
//        }
