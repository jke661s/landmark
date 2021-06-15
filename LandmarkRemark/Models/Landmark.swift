//
//  Landmark.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 14/6/21.
//

import Foundation
import RealmSwift

@objcMembers class Landmark: Object {
    dynamic var location: Location?
    dynamic var landMarkDescription: String = ""
    dynamic var username: String = ""
    
    convenience init(location: Location,
                     description: String,
                     username: String) {
        self.init()
        self.location = location
        self.landMarkDescription = description
        self.username = username
    }
}
