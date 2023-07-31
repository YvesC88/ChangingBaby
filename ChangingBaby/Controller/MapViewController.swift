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
    
    let locationManager = CLLocationManager()
    let userService = UserService(wrapper: FirebaseWrapper())
    var userPosition: CLLocation?
    var firstRequest: Bool = true
    
    var place: [Place] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPlaces()
        setupLocationManager()
    }
    
    func loadPlaces() {
        let service = PlaceService(wrapper: FirebaseWrapper())
        service.fetchPlaces(collectionID: "places") { place, error in
            for data in place {
                self.place.append(data)
            }
            self.setupPin()
        }
    }
    
    @IBAction func getPosition(_ sender: Any) {
        guard let userPosition = userPosition else { return }
        mapView.setRegion(MKCoordinateRegion(center: userPosition.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
    }
    
    @IBAction func newPlace() {
        if userService.isLogin {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let sheetPresentationController = storyboard.instantiateViewController(withIdentifier: "FormViewController") as? FormViewController else { return }
            let navPlacesController = UINavigationController(rootViewController: sheetPresentationController)
            setupUINavigationBar(navController: navPlacesController)
            self.present(navPlacesController, animated: true, completion: nil)
        } else {
            self.presentAlert(title: "Oups", message: "Vous devez être connecté pour ajouter un lieu.")
        }
    }
    
    // to set the view of the current user's location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard locations.count > 0 else { return }
        guard let myLocation = locations.last else { return }
        userPosition = myLocation
        guard firstRequest else { return }
        mapView.setRegion(MKCoordinateRegion(
            center: userPosition!.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01,
                                   longitudeDelta: 0.01)), animated: true)
        firstRequest = false
    }
}

extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    // to set all of pins on map
    func setupPin() {
            guard !place.isEmpty else { return }
            for object in place {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: object.lat, longitude: object.long)
                annotation.title = object.name
                mapView.addAnnotation(annotation)
                mapView.delegate = self
                mapView.isRotateEnabled = true
            }
        }
    
    // filter and display the pin selected by user in DetailPlaceViewController
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotation) {
        let selectedAnnotation = place.filter { $0.lat == view.coordinate.latitude && $0.long == view.coordinate.longitude }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let sheetPresentationController = storyboard.instantiateViewController(withIdentifier: "DetailPlaceViewController") as? DetailPlaceViewController else { return }
        sheetPresentationController.place = selectedAnnotation
        let navPlacesController = UINavigationController(rootViewController: sheetPresentationController)
        setupUINavigationBar(navController: navPlacesController)
        self.present(navPlacesController, animated: true, completion: nil)
    }
    
    // parameters for locationManager
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.startUpdatingHeading()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // set custom ui for nav bar
    func setupUINavigationBar(navController: UINavigationController) {
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithDefaultBackground()
        standardAppearance.backgroundColor = UIColor(red: 49/255, green: 48/255, blue: 121/255, alpha: 1)
        standardAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.tintColor = UIColor.white
        navController.navigationBar.isTranslucent = true
        navController.navigationBar.scrollEdgeAppearance = standardAppearance
    }
}
