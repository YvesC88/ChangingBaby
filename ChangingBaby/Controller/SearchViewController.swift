//
//  SearchVC.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 28/01/2023.
//

import UIKit

class SearchViewController: UIViewController, UISearchResultsUpdating {
    
    let searchController = UISearchController(searchResultsController: SearchResultsViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recherche"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Rechercher un lieu"
        navigationItem.searchController = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        let vc = searchController.searchResultsController as? SearchResultsViewController
        vc?.update(text: text)
        vc?.filtered()
    }
    
    @IBAction func dismissAccount() {
        dismiss(animated: true)
    }
}
