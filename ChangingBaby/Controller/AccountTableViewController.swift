//
//  AccountTableViewController.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 01/02/2023.
//

import Foundation
import UIKit

class AccountTableViewController: UITableViewController {
    
    let userService = UserService(wrapper: FirebaseWrapper())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        isUserLogin()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        isUserLogin()
    }
    
    func isUserLogin() {
        guard userService.isLogin else {
            title = "Bienvenue"
            return
        }
        // show name'user
        title = "Bienvenue \(userService.getUser()?.displayName ?? "")"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if userService.isLogin {
            if indexPath.section == 0 {
                if indexPath.row == 0 || indexPath.row == 1 {
                    return 0
                }
            }
        } else {
            if indexPath.section == 1 {
                if indexPath.row == 0 || indexPath.row == 1 {
                    return 0
                }
            }
            if indexPath.section == 2 {
                return 0
            }
        }
        return tableView.rowHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let alertVC = UIAlertController(title: "Se déconnecter ?", message: "Voulez-vous vraiment vous déconnecter ?", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Se déconnecter", style: .destructive) { action in
                // signOut the user and back to HomeViewController
                self.userService.signOut { result, error in
                    if result != nil && error == nil {
                        // user isn't signouted and has an error
                        self.presentAlert(title: "Oups", message: "Une erreur s'est produite. Veuillez réessayer.")
                    } else {
                        self.dismiss(animated: true) {
                            self.isUserLogin()
                        }
                    }
                }
            }
            alertVC.addAction(confirmAction)
            let cancelAction = UIAlertAction(title: "Annuler", style: .cancel)
            alertVC.addAction(cancelAction)
            present(alertVC, animated: true, completion: nil)
        }
    }
}
