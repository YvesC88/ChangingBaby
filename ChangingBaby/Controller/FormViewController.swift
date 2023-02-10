//
//  FormViewController.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 06/02/2023.
//

import Foundation
import UIKit

class FormViewController: UIViewController {
    
    @IBOutlet weak var placeNameTextField: UITextField!
    @IBOutlet weak var streetNumberTextField: UITextField!
    @IBOutlet weak var streetNameTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var validateButton: UIButton!
    
    let placeService = PlaceService(wrapper: FirebaseWrapper())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIButton(button: [validateButton])
    }
    
    @IBAction func didTapValidate() {
        if let placeName = placeNameTextField.text, let streetNumber = streetNumberTextField.text, let streetName = streetNameTextField.text, let city = cityTextField.text {
            if !placeName.isEmpty, !streetName.isEmpty, !city.isEmpty {
                self.placeService.addNewPlace(name: placeName,
                                              streetNumber: streetNumber,
                                              streetName: streetName,
                                              city: city)
                print(placeName, streetNumber, streetName, city)
                let alertVC = UIAlertController(title: "Succès", message: "Votre demande sera analysée. Merci pour votre collaboration !", preferredStyle: .alert)
                let confirmAction = UIAlertAction(title: "Valider", style: .default) { action in
                    self.dismiss(animated: true)
                }
                alertVC.addAction(confirmAction)
                present(alertVC, animated: true, completion: nil)
            } else {
                self.presentAlert(title: "Oups", message: "Un champ est manquant.")
            }
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        let textField = [placeNameTextField, streetNumberTextField, streetNameTextField, cityTextField]
        for field in textField {
            self.dismissKeyboard(sender, textField: field!)
        }
    }
}

extension FormViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let userText = (textField.text as? NSString)?.replacingCharacters(in: range, with: string).trimmingCharacters(in: .whitespacesAndNewlines) {
            if userText.isEmpty {
                validateButton.isEnabled = false
            } else {
                validateButton.isEnabled = true
            }
        }
        return true
    }
}
