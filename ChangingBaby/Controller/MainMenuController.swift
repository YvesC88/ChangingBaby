//
//  MainMenuController.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 30/11/2021.
//

import UIKit

class MainMenuController: UIViewController {
    @IBOutlet weak var interfaceView: UIView!
    
    @IBAction func showContactsView() {
        interfaceView.backgroundColor = .magenta
    }
    @IBAction func showTips() {
        interfaceView.backgroundColor = .blue
    }
    @IBAction func showMore() {
        interfaceView.backgroundColor = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sheetPresentationController?.detents = [.medium()]
        // Do any additional setup after loading the view.
    }
}
