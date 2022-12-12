//
//  MapViewController.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 22/11/2021.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var getPositionButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var accountButton: UIButton!
    
    let locationManager = CLLocationManager()
    var userPosition: CLLocation?
    var firstRequest: Bool = true
    
    var place: [Place] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupLocationManager()
    }
    
    func loadData() {
        let service = PlaceService()
        service.fetchPlaces(collectionID: "places") { place in
            self.place = place
            self.setupPin()
        }
    }
    
    // get current user's position
    @IBAction func getPosition(_ sender: Any) {
        guard userPosition != nil else { return }
        mapView.setRegion(MKCoordinateRegion(center: userPosition!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
    }
    
    @IBAction func presentMenu() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let sheetPresentationController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        let navMenuController = UINavigationController(rootViewController: sheetPresentationController)
        setupUINavigationBar(navController: navMenuController)
        self.present(navMenuController, animated: true, completion: nil)
    }
    
    @IBAction func backToHome(_ sender: Any) {
        self.presentVC(with: "AccountViewController")
    }
    
    @IBAction func search() {
        self.presentVC(with: "SearchViewController")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locations.count > 0 else { return }
        guard let myPosition = locations.last else { return }
        userPosition = myPosition
        guard firstRequest else { return }
        mapView.setRegion(MKCoordinateRegion(
            center: userPosition!.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01,
                                   longitudeDelta: 0.01)), animated: true)
        firstRequest = false
    }
}

extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    // affiche tous les points sur la carte
    func setupPin() {
        guard self.place.count > 0 else { return }
        for object in 0...self.place.count - 1 {
            mapView.addAnnotation(Poi(name: place[object].name,
                                      coordinate: CLLocationCoordinate2D(
                                        latitude: place[object].lat,
                                        longitude: place[object].long)))
            mapView.delegate = self
            mapView.isRotateEnabled = true
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotation) {
        let selectedAnnotation = place.filter { $0.lat == view.coordinate.latitude && $0.long == view.coordinate.longitude }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let sheetPresentationController = storyboard.instantiateViewController(withIdentifier: "DetailPlaceViewController") as? DetailPlaceViewController else { return }
        sheetPresentationController.place = selectedAnnotation
        let navPlacesController = UINavigationController(rootViewController: sheetPresentationController)
        setupUINavigationBar(navController: navPlacesController)
        self.present(navPlacesController, animated: true, completion: nil)
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.startUpdatingHeading()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
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
