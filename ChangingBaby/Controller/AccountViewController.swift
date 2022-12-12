//
//  AccountViewController.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 09/11/2022.
//

import UIKit

class AccountViewController: UIViewController {
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dismissButton: UIButton!
    
    let userService = UserService(wrapper: FirebaseWrapper())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sheetPresentationController?.detents = [.medium()]
        self.sheetPresentationController?.prefersGrabberVisible = true
        isUserLogin()
        self.setUIButton(buttons: [signUpButton, signInButton])
    }
    
    // check if user is login
    func isUserLogin() {
        guard userService.isLogin else {
            titleLabel.text = "Bienvenue"
            signInButton.setTitle("Connexion", for: .normal)
            signUpButton.isHidden = false
            return
        }
        // show name'user
        titleLabel.text = "Bienvenue \(userService.getUser()?.displayName ?? "")"
        signInButton.setTitle("Déconnexion", for: .normal)
        signUpButton.isHidden = true
    }
    
    @IBAction func logButtonTapped() {
        // if user is connected
        guard userService.isLogin else {
            // if user isn't connected and present LoginViewController
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
            vc.delegate = self
            vc.modalPresentationStyle = .automatic
            self.present(vc, animated:true)
            return
        }
        // signOut the user and back to HomeViewController
        userService.signOut { result, error in
            if result != nil && error == nil {
                // user isn't signouted and has an error
                self.presentAlert(title: "Erreur", message: "Une erreur s'est produite. Veuillez réessayer.")
            } else {
                self.dismiss(animated: true) {
                    self.toChangeVC(with: "HomeViewController")
                }
            }
        }
    }
    
    // objectif de signUp est de présenter SignUpViewController
    @IBAction func signUp() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @IBAction func dismissAccountViewController(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension AccountViewController: SelectionDelegate {
    func didFinishAction() {
        dismiss(animated: true) {
            self.dismiss(animated: true)
        }
    }
}
