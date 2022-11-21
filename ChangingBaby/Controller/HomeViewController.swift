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
    
    func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func guestButtonTapped() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func setUI() {
        if userService.isLogin {
            goToMapVC(animated: false)
        }
        loginViewController.setupUIButton(button: loginButton)
    }
    
    func goToMapVC(animated: Bool) {
        self.navigationController?.popViewController(animated: animated)
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}


/* MARK: - Dépop un VC et remplacer par un autre
 self.navigationController?.popViewController(animated: animated)
 let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
 let vc = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
 vc.modalPresentationStyle = .fullScreen
 present(vc, animated: animated)
 
 MARK: - Push un VC au dessus d'un autre
 let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
 let vc = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
 navigationController?.pushViewController(vc, animated: animated)
 
 */
