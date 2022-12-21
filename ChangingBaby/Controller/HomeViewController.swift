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
    
    let userService = UserService(wrapper: FirebaseWrapper())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    // to ignore the homeViewController
    @IBAction func guestButtonTapped() {
        self.toChangeVC(with: "MapViewController")
    }
    
    // to sign up a new user
    @IBAction func didTapSignUp() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
        vc.delegate = self
        present(vc, animated: true)
    }
    
    // to log in a user
    @IBAction func didTapSignIn() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController else { return }
        vc.delegate = self
        present(vc, animated: true)
    }
    
    // to custom ui button and set MapViewController is user is login
    func setUI() {
        guard userService.isLogin else {
            self.setUIButton(buttons: [signUpButton, signInButton])
            return
        }
        self.toChangeVC(with: "MapViewController")
    }
}

extension HomeViewController: SelectionDelegate {
    // action to perform if user is on HomeViewController
    func didFinishAction() {
        dismiss(animated: true) {
            self.toChangeVC(with: "MapViewController")
        }
    }
}
