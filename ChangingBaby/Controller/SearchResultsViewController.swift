//
//  SearchViewController.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 15/11/2022.
//

import UIKit
import MapKit

class SearchResultsViewController: UIViewController {
    
    var mapView = MKMapView()
    var tableView = UITableView()
    var userText: String = ""
    
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
        tableView.keyboardDismissMode = .onDrag
        let height = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        tableView = UITableView(frame: CGRect(x: 0, y: height, width: displayWidth, height: displayHeight - height))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        loadData()
        filteredPlace = place
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // load the place from firestore
    func loadData() {
        let service = PlaceService(wrapper: FirebaseWrapper())
        service.fetchPlaces(collectionID: "places") { place, error in
            for data in place {
                self.place.append(data)
            }
        }
    }
    
    func update(text: String) {
        userText = text
    }
    
    func filtered() {
        filteredPlace = []
        for word in place {
            if word.name.uppercased().hasPrefix(userText.uppercased()) {
                filteredPlace.append(word)
            }
        }
        self.tableView.reloadData()
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

extension SearchResultsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPlace.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let filteredPlace = filteredPlace[indexPath.row]
        cell.textLabel?.text = "\(filteredPlace.name), \(filteredPlace.city)"
        cell.detailTextLabel?.text = "Test"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < filteredPlace.count else { return }
        let selectedPlace = filteredPlace[indexPath.row]
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: selectedPlace.lat, longitude: selectedPlace.long), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "DetailPlaceViewController") as? DetailPlaceViewController else { return }
        vc.place = [selectedPlace]
        let navPlacesController = UINavigationController(rootViewController: vc)
        setupUINavigationBar(navController: navPlacesController)
        self.present(navPlacesController, animated: true, completion: nil)
    }
}

extension SearchResultsViewController: UISearchBarDelegate {
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
