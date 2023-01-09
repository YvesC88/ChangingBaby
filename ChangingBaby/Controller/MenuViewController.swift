//
//  MenuViewController.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 30/11/2021.
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let menu = ["Astuces"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // dismiss the menu
    @IBAction func dismissMenu() {
        dismiss(animated: true, completion: nil)
    }
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    // return the number of section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    // display section
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let menu = menu[indexPath.row]
        cell.textLabel?.text = menu
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "TipsViewController") as? TipsViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
