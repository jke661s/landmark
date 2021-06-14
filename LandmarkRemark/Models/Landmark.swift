//
//  Landmark.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 14/6/21.
//

import Foundation

struct Landmark {
    let location: Location
    let description: String
    let username: String
    
    init(location: Location,
         description: String,
         username: String) {
        self.location = location
        self.description = description
        self.username = username
    }
}
