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
    var userPosition: CLLocation?
    var firstRequest: Bool = true
    
    var place: [Place] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupLocationManager()
    }
    
    // load the place from firestore
    func loadData() {
        let service = PlaceService(wrapper: FirebaseWrapper())
        service.fetchPlaces(collectionID: "places") { place, error in
            for data in place {
                self.place.append(data)
            }
            self.setupPin()
        }
    }
    
    // get current user's position
    @IBAction func getPosition(_ sender: Any) {
        guard userPosition != nil else { return }
        mapView.setRegion(MKCoordinateRegion(center: userPosition!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
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
        guard self.place.count > 0 else { return }
        for object in 0...self.place.count - 1 {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: place[object].lat, longitude: place[object].long)
            annotation.title = place[object].name
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
