//
//  HomeViewController.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 07/11/2022.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var guestButton: UIButton!
    
    let userService = UserService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    @IBAction func guestButtonTapped() {
        toNextViewController(animated: true)
    }
    
    @IBAction func didTapSignUp() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @IBAction func didTapSignIn() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController else { return }
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func setUI() {
        guard userService.isLogin else {
            self.setupUIButton(button: signInButton)
            return
        }
        toNextViewController(animated: true)
    }
    
    func toNextViewController(animated: Bool) {
        guard let navController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController else { return }
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        navController.setViewControllers([vc], animated: animated)
    }
}

extension HomeViewController: SelectionDelegate {
    func didFinishAction() {
        dismiss(animated: true) {
            guard let navController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController else { return }
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
            navController.setViewControllers([vc], animated: true)
        }
    }
}
