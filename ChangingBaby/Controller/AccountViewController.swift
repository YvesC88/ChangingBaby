//
//  AccountViewController.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 09/11/2022.
//

import UIKit

class AccountViewController: UIViewController {
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dismissButton: UIButton!
    
    let userService = UserService()
    let homeViewController = HomeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sheetPresentationController?.detents = [.medium()]
        // vérifier le statut de l'utilisateur
        isUserLogin()
    }
    
    // check if user is login
    func isUserLogin() {
        if userService.isLogin {
            // affiche le nom de l'utilisateur
            titleLabel.text = "Bienvenue"
            loginButton.setTitle("Déconnexion", for: .normal)
            signUpButton.isHidden = true
        } else {
            titleLabel.text = "Bienvenue"
            loginButton.setTitle("Connexion", for: .normal)
            signUpButton.isHidden = false
        }
    }
    
    @IBAction func test() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.present(vc, animated: true)
    }
    
    @IBAction func logButtonTapped() {
        // if user is connected
        if userService.isLogin {
            // logout the user and go to HomeViewController
            userService.signOut()
            dismiss(animated: true) {
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            // if user isn't connected and pop LoginViewController
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            vc.modalPresentationStyle = .automatic
            self.present(vc, animated:true)
        }
    }
    
    // objectif de signUp est de présenter SignUpViewController
    @IBAction func signUp() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
        present(vc, animated: true)
    }
    
    @IBAction func dismissAccountViewController(_ sender: Any) {
        dismiss(animated: true)
    }
}
