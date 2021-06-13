//
//  Location.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 12/6/21.
//

import Foundation
import CoreLocation

struct Location: Codable {
    let latitude: Double
    let longitude: Double
    let accuracy: Double
    
    init(_ cLLocation: CLLocation) {
        self.latitude = cLLocation.coordinate.latitude
        self.longitude = cLLocation.coordinate.longitude
        self.accuracy = cLLocation.horizontalAccuracy
    }
}
