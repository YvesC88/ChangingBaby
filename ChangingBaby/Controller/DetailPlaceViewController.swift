//
//  DetailPlaceViewController.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 02/12/2021.
//

import UIKit
import MapKit

class DetailPlaceViewController: UIViewController {
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var openingHoursTextView: UITextView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var itineraryButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var place: [Place]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIPlace(place: place.first!)
    }
    
    func setUIPlace(place: Place) {
        title = place.name
        addressLabel.text = "\(place.streetNumber) \(place.streetName) \n\(place.zip) \(place.city)\nFrance"
        categoryLabel.text = place.category
        openingHoursTextView.text = place.hours.joined(separator: "\n")
    }
    
    @IBAction func dismissDetailPlaceViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func itineraryTo() {
        let coordinate = CLLocationCoordinate2D(latitude: place.first?.lat ?? 0.0, longitude: place.first?.long ?? 0.0)
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = place.first?.name
        mapItem.openInMaps()
    }
}
