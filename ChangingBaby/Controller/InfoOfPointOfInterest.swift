//
//  InfoOfPointOfInterest.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 02/12/2021.
//

import UIKit

class InfoOfPointOfInterest: UIViewController {
    
    @IBOutlet weak var infosOfPlaces: UITableView!
    
    @IBAction func closeTableView() {
        dismiss(animated: true, completion: nil)
    }
    
    let listInformation = ["Photos", "Horaires", "Adresse", "Note", "Avis"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sheetPresentationController?.detents = [.medium(), .large()]

        infosOfPlaces.delegate = self
        infosOfPlaces.dataSource = self
        infosOfPlaces.allowsSelection = false
        // Do any additional setup after loading the view.
    }
}

extension InfoOfPointOfInterest: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listInformation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = infosOfPlaces.dequeueReusableCell(withIdentifier: "customCellPlaces") as! InfoOfPlacesCell
        let menu = listInformation[indexPath.row]
        cell.labelLine.text = menu
        return cell
    }
}
