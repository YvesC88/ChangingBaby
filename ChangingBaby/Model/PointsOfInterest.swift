//
//  PointsOfInterest.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 23/11/2021.
//

import UIKit
import MapKit

struct Places {
    static let enfantsrouges = Poi(title: "Les Enfants Rouges", coordinate: CLLocationCoordinate2DMake(43.61021423339844, 3.875974416732788), info: "Restaurant")
    static let mcdonalds = Poi(title: "Mc Donald's", coordinate: CLLocationCoordinate2DMake(43.60868995132711, 3.879343621296849), info: "Fast Food")
    static let pizzapapa = Poi(title: "La Pizza Papa", coordinate: CLLocationCoordinate2DMake(43.60848617553711, 3.880244493484497), info: "Restaurant")
    static let gaumontcomedie = Poi(title: "Gaumont", coordinate: CLLocationCoordinate2DMake(43.60909210965402, 3.8799910247325897), info: "Cinéma")
    static let shakesspeare = Poi(title: "The Sheakespeare", coordinate: CLLocationCoordinate2DMake(43.61053797585777, 3.878415897488594), info: "Bar")
}

class Poi: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
