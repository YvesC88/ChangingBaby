//
//  MainMenuController.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 30/11/2021.
//

import UIKit

class MainMenuController: UIViewController {
    @IBOutlet weak var mainMenuView: UITableView!
    
    let menu = ["Astuces", "Contact"]
    
    @IBAction func closeTableView() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sheetPresentationController?.detents = [.medium()]
        
        mainMenuView.delegate = self
        mainMenuView.dataSource = self
        mainMenuView.allowsSelection = false
        // Do any additional setup after loading the view.
    }
}

extension MainMenuController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainMenuView.dequeueReusableCell(withIdentifier: "customCell") as! MainMenuCell
        let menu = menu[indexPath.row]
        cell.labelLine.text = menu
        return cell
    }
}
