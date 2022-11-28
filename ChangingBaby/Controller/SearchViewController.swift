//
//  SearchViewController.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 15/11/2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController()
    var place: [Place] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var filteredPlace: [Place]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        filteredPlace = place
        tableView.delegate = self
        tableView.dataSource = self
        self.sheetPresentationController?.detents = [.medium()]
    }
    
    func loadData() {
        let service = PlaceService()
        service.fetchPlaces(collectionID: "places") { place in
            for data in place {
                self.place.append(data)
            }
        }
    }
    
    func setupUINavigationBar(navController: UINavigationController) {
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithDefaultBackground()
        standardAppearance.backgroundColor = UIColor.tintColor
        standardAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.isTranslucent = true
        navController.navigationBar.scrollEdgeAppearance = standardAppearance
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredPlace.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filteredPlace[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < filteredPlace.count else { return }
        let selectedPlace = filteredPlace[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "PlaceController") as? PlaceController else { return }
        vc.place = [selectedPlace]
        let navPlacesController = UINavigationController(rootViewController: vc)
        setupUINavigationBar(navController: navPlacesController)
        self.present(navPlacesController, animated: true, completion: nil)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPlace = []
        for word in place {
            if word.name.uppercased().contains(searchText.uppercased()) {
                filteredPlace.append(word)
            }
        }
        self.tableView.reloadData()
    }
}
