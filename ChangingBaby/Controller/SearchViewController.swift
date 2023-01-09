//
//  SearchViewController.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 15/11/2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
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
        self.tableView.keyboardDismissMode = .onDrag
        loadData()
        filteredPlace = place
        tableView.delegate = self
        tableView.dataSource = self
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        if navigationItem.searchController == nil {
//            navigationItem.searchController = searchController
//        }
//    }
    
    // load the place from firestore
    func loadData() {
        let service = PlaceService(wrapper: FirebaseWrapper())
        service.fetchPlaces(collectionID: "places") { place, error in
            for data in place {
                self.place.append(data)
            }
        }
    }
    
    // set ui for nav bar
    func setupUINavigationBar(navController: UINavigationController) {
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithDefaultBackground()
        standardAppearance.backgroundColor = UIColor(red: 49/255, green: 48/255, blue: 121/255, alpha: 1)
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
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailPlaceViewController") as? DetailPlaceViewController else { return }
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
