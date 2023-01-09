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
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    let userService = UserService(wrapper: FirebaseWrapper())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isUserLogin()
        self.setUIButton(button: [signUpButton, signInButton, deleteButton])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isUserLogin()
        self.setUIButton(button: [signUpButton, signInButton, deleteButton])
    }
    
    // check if user is login
    func isUserLogin() {
        guard userService.isLogin else {
            titleLabel.text = "Bienvenue"
            signInButton.setTitle("Connexion", for: .normal)
            signUpButton.isHidden = false
            deleteButton.isHidden = true
            return
        }
        // show name'user
        titleLabel.text = "Bienvenue \(userService.getUser()?.displayName ?? "")"
        signInButton.setTitle("Déconnexion", for: .normal)
        signUpButton.isHidden = true
        deleteButton.isHidden = false
    }
    
    @IBAction func logButtonTapped() {
        // if user is connected
        guard userService.isLogin else {
            // if user isn't connected and present LoginViewController
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "SignInViewController")
            navigationController?.pushViewController(vc, animated: true)
            return
        }
        // signOut the user and back to HomeViewController
        userService.signOut { result, error in
            if result != nil && error == nil {
                // user isn't signouted and has an error
                self.presentAlert(title: "Erreur", message: "Une erreur s'est produite. Veuillez réessayer.")
            } else {
                self.dismiss(animated: true) {
                    self.isUserLogin()
                }
            }
        }
    }
    
    @IBAction func signUp() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignUpViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func deleteUser() {
        isUserLogin()
        let alertVC = UIAlertController(title: "Supprimer le compte", message: "Êtes-vous sûr de vouloir supprimer votre compte ? Cela effacera définitivement vos données.", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Annuler", style: .default)
        alertVC.addAction(confirmAction)
        let cancelAction = UIAlertAction(title: "Effacer", style: .destructive) { action in
            self.dismiss(animated: true) {
                self.userService.deleteUser()
            }
        }
        alertVC.addAction(cancelAction)
        alertVC.preferredAction = confirmAction
        present(alertVC, animated: true, completion: nil)
        isUserLogin()
    }
    
    @IBAction func dismissAccount() {
        dismiss(animated: true)
    }
}
