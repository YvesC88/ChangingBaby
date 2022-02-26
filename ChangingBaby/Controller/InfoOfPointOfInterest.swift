//
//  InfoOfPointOfInterest.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 02/12/2021.
//

import UIKit

class InfoOfPointOfInterest: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sheetPresentationController?.detents = [.medium(), .large()]

        // Do any additional setup after loading the view.
    }
}
