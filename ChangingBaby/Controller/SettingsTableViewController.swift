//
//  AccountSettingsTableViewController.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 03/02/2023.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    let userService = UserService(wrapper: FirebaseWrapper())
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
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
        }
    }
}
