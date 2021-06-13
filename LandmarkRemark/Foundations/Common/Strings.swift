//
//  Strings.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 13/6/21.
//

import Foundation

struct Strings {
    struct Error {
        static let failToGetLocation = "Failed to get location"
    }
    
    struct FatalError {
        static let initCoderNotImplemented = "init(coder:) has not been implemented"
    }
    
    struct Generic {
        static let cancel = "Cancel"
        static let ok = "OK"
    }
    
    struct Alert {
        struct Generic {
            static let title = "Oops!"
            static let message = "Something went wrong. Please try again later."
        }
        
        struct LocationPermission {
            static let title = "Permission Denied"
            static let message = "Sorry. We do not have the location permission. Please go to setting to grant it and try again."
        }
    }
    
    struct ViewControllers {
        struct Main {
            static let title = "Home"
        }
        
        struct LandmarkDetails {
            static let path = "landMarkDetails"
            static let landMarkId = "landMarkId"
        }
        
        struct SaveLandmark {
            static let path = "saveLandmark"
        }
    }
    
    static let empty = ""
}
