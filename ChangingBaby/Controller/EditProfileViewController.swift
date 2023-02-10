//
//  EditProfileViewController.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 03/02/2023.
//

import Foundation
import UIKit

class EditProfileViewController: UIViewController {
    
    let userService = UserService(wrapper: FirebaseWrapper())
    
    @IBOutlet weak var newNameTextField: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserInfo()
        self.setUIButton(button: [updateButton])
    }
    
    func setUserInfo() {
        newNameTextField.text = userService.getUser()?.displayName
    }
    
    @IBAction func updateProfile() {
        if let newName = newNameTextField.text {
            userService.updateUserName(userName: newName) { userName, errorMessage in
                if let navigationController = self.navigationController {
                    navigationController.popViewController(animated: true)
                }
            }
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        let textField = [newNameTextField]
        for field in textField {
            self.dismissKeyboard(sender, textField: field!)
        }
    }
}

extension EditProfileViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let userText = (textField.text as? NSString)?.replacingCharacters(in: range, with: string).trimmingCharacters(in: .whitespacesAndNewlines) {
            if userText.isEmpty {
                updateButton.isEnabled = false
            } else {
                updateButton.isEnabled = true
            }
        }
        return true
    }
}
