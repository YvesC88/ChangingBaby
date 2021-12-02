//
//  MainMenuController.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 30/11/2021.
//

import UIKit

class MainMenuController: UIViewController {
    @IBOutlet weak var closeButton: UIButton!
    
    @IBAction func closeMenu() {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sheetPresentationController?.detents = [.medium()]
        // Do any additional setup after loading the view.
    }
}
