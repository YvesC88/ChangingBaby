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
        isUserLogin()
    }
    
    // check if user is login
    func isUserLogin() {
        guard userService.isLogin else {
            titleLabel.text = "Bienvenue"
            loginButton.setTitle("Connexion", for: .normal)
            signUpButton.isHidden = false
            return
        }
        // show name'user
        titleLabel.text = "Bienvenue \(userService.getUser()?.displayName ?? "")"
        loginButton.setTitle("Déconnexion", for: .normal)
        signUpButton.isHidden = true
    }
    
    @IBAction func logButtonTapped() {
        // if user is connected
        guard userService.isLogin else {
            //             if user isn't connected and present LoginViewController
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            vc.modalPresentationStyle = .automatic
            self.present(vc, animated:true)
            return
        }
        // signOut the user and back to HomeViewController
        userService.signOut()
        dismiss(animated: true) {
            guard let navController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController else { return }
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            navController.setViewControllers([vc], animated: true)
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
