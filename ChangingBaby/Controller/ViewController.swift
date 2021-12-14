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
        let storyboard = UIStoryboard(name: "MainMenu", bundle: nil)
        let sheetPresentationController = storyboard.instantiateViewController(withIdentifier: "MainMenuController") as! MainMenuController
        self.present(sheetPresentationController, animated: true, completion: nil)
    }
}

extension ViewController: MKMapViewDelegate {
    func setup() {
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinateInit, span: span)
        mapView.addAnnotations([Places.enfantsrouges, Places.gaumontcomedie, Places.mcdonalds, Places.pizzapapa, Places.shakesspeare])
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
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let storyboard = UIStoryboard(name: "SheetOfPoi", bundle: nil)
        let sheetPresentationController = storyboard.instantiateViewController(withIdentifier: "InfoOfPointOfInterest") as! InfoOfPointOfInterest
        self.present(sheetPresentationController, animated: true, completion: nil)
    }
    
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//        //        guard let pointOfInterest = view.annotation as? PointOfInterest else { return }
//        
//        let storyboard = UIStoryboard(name: "SheetOfPoi", bundle: nil)
//        let sheetPresentationController = storyboard.instantiateViewController(withIdentifier: "InfoOfPointOfInterest") as! InfoOfPointOfInterest
//        self.present(sheetPresentationController, animated: true, completion: nil)
//    }
}

extension ViewController: CLLocationManagerDelegate {
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.startUpdatingHeading()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
}

/*
 guard let pointOfInterest = view.annotation as? PointOfInterest else { return }
 
 let title = pointOfInterest.title
 let info = pointOfInterest.info
 
 let presentInfoAnnotation = UIAlertController(title: title, message: info, preferredStyle: .actionSheet)
 presentInfoAnnotation.addAction(UIAlertAction(title: title, style: .default, handler: { _ in
 let storyboard = UIStoryboard(name: "SheetOfPoi", bundle: nil)
 let sheetPresentationController = storyboard.instantiateViewController(withIdentifier: "InfoOfPointOfInterest") as! InfoOfPointOfInterest
 self.present(sheetPresentationController, animated: true, completion: nil)
 }))
 */
