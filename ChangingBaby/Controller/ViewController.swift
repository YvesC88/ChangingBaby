//
//  ViewController.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 22/11/2021.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var getPosition: UIButton!
    @IBOutlet weak var logoName: UILabel!
    @IBOutlet weak var mainMenu: UIButton!
    
    // coordonnees geographiques par defaut
    var defaultLatitude: Double = 43.6112422
    var defaultLongitude: Double = 3.8767337
    var coordinateInit :  CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: defaultLatitude, longitude: defaultLongitude)
    }
    let locationManager = CLLocationManager()
    var userPosition: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupLocationManager()
        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            if let myPosition = locations.last {
                userPosition = myPosition
            }
        }
    }
    // donne sa position actuelle
    @IBAction func getPosition(_ sender: Any) {
        if userPosition != nil {
            setupMap(coordonnees: userPosition!.coordinate, myLat: 0.005, myLong: 0.005)
        }
    }
    @IBAction func presentMenu() {
        let detailViewController = MainMenuController()
        let nav = UINavigationController(rootViewController: detailViewController)
        
        nav.modalPresentationStyle = .formSheet
        
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium()]
        }
        present(nav, animated: true, completion: nil)
    }
}
extension ViewController: MKMapViewDelegate {
    func setup() {
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinateInit, span: span)
        mapView.addAnnotations([Place.enfantsrouges, Place.gaumontcomedie, Place.mcdonalds, Place.pizzapapa, Place.shakesspeare])
        mapView.setRegion(region, animated: true)
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.isRotateEnabled = true
    }
    
    func setupMap(coordonnees: CLLocationCoordinate2D, myLat: Double, myLong: Double) {
        let span = MKCoordinateSpan(latitudeDelta: myLat , longitudeDelta: myLong)
        let region = MKCoordinateRegion(center: coordonnees, span: span)
        mapView.setRegion(region, animated: true)
    }
}

extension ViewController: CLLocationManagerDelegate {
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.startUpdatingHeading()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
}
