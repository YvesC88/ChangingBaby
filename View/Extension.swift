//
//  Extension.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 26/11/2022.
//

import UIKit
import Firebase

extension UIViewController {
    
    func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    func dismissKeyboard(_ sender: UITapGestureRecognizer, textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func setUIButton(buttons: [UIButton]) {
        let buttons = buttons
        for button in buttons {
            button.layer.borderColor = CGColor(red: 49/255, green: 48/255, blue: 121/255, alpha: 1)
            button.layer.cornerRadius = 25
            button.layer.borderWidth = 2
        }
    }
    
    func toChangeVC(with identifier: String) {
        guard let navController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController else { return }
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        navController.setViewControllers([vc], animated: true)
    }
    
    func presentVC(with identifier: String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: identifier)
        self.present(vc, animated:true)
    }
}

extension AuthErrorCode.Code {
    var errorMessage: String {
        switch self {
        case .weakPassword:
            return "Le mot de passe doit contenir 6 caractères ou plus."
        case .tooManyRequests:
            return "Trop de mauvaises tentatives. Réessayez plus tard."
        case .wrongPassword:
            return "Le mot de passe est invalide ou l'utilisateur n'a pas de mot de passe."
        case .invalidEmail:
            return "L'adresse email n'est pas correctement formatée."
        case .emailAlreadyInUse:
            return "L'adresse email est déjà utilisée par un autre compte."
        case .userNotFound:
            return "Il n'y a pas d'utilisateur correspondant à cet email."
        case .missingEmail:
            return "L'adresse email est manquante."
        default:
            return "Désolé, quelque chose ne va pas."
        }
    }
}

protocol SelectionDelegate {
    func didFinishAction()
}
