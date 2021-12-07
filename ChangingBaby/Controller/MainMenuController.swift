//
//  MainMenuController.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 30/11/2021.
//

import UIKit

class MainMenuController: UIViewController, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
//    let choice = ["Astuces", "Profil", "Autres"]
    
    @IBAction func closeTableView() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sheetPresentationController?.detents = [.medium()]
//        tableView.delegate = self
//        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
}
//
//extension MainMenuController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.choice.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return choice.count
//    }
//}
