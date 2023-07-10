//
//  HomeViewController.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 07/11/2022.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var orangeView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUIView(view: [topView, orangeView])
        updateDateLabel()
    }
    
    private func updateDateLabel() {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.locale = Locale(identifier: "FR-fr")
        dateLabel.text = "\(dateFormatter.string(from: now))"
    }
}
