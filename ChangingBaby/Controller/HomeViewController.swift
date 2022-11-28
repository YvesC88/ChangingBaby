//
//  HomeViewController.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 07/11/2022.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var guestButton: UIButton!
    
    let userService = UserService()
    let loginViewController = LoginViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    @IBAction func guestButtonTapped() {
        guard let navController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController else { return }
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        navController.setViewControllers([vc], animated: true)
    }
    
    func setUI() {
        guard userService.isLogin else {
            loginViewController.setupUIButton(button: loginButton)
            return
        }
        goToMapVC(animated: true)
    }
    
    func goToMapVC(animated: Bool) {
        guard let navController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController else { return }
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
            navController.setViewControllers([vc], animated: animated)
    }
}
