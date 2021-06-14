//
//  Location.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 12/6/21.
//

import Foundation
import CoreLocation
import RealmSwift

@objcMembers class Location: Object, Codable {
    dynamic var privateKey: String = UUID().uuidString
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    dynamic var accuracy: Double = 0.0
    
    convenience init(_ cLLocation: CLLocation) {
        self.init()
        self.latitude = cLLocation.coordinate.latitude
        self.longitude = cLLocation.coordinate.longitude
        self.accuracy = cLLocation.horizontalAccuracy
    }
    
    override class func primaryKey() -> String? {
        "privateKey"
    }
}
