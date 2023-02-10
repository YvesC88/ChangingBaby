//
//  Place.swift
//  ChangingBaby
//
//  Created by Yves Charpentier on 24/10/2022.


import Foundation
import CoreLocation
import MapKit

// Parsing and object Place is create
struct Place: Codable {
    // MARK: - Properties
    
    let name, streetNumber, streetName, city, category: String
    let zip: Int
    let lat, long: Double
    let hours: [String]
}
