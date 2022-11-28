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
