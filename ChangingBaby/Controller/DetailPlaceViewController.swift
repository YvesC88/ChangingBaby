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
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var itineraryButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var place: [Place]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUIPlace()
        self.sheetPresentationController?.detents = [.medium(), .large()]
    }
    
    func setUIPlace() {
        for i in self.place {
            self.title = i.name
            self.addressLabel.text = "\(i.streetNumber) \(i.streetName) \n\(i.zip) \(i.city)\nFrance"
            self.categoryLabel.text = i.category
        }
    }
    
    @IBAction func closePlaceController() {
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
