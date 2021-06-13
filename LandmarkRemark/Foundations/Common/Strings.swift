//
//  Strings.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 13/6/21.
//

import Foundation

struct Strings {
    struct FatalError {
        static let initCoderNotImplemented = "init(coder:) has not been implemented"
    }
    
    static let empty = ""
    
    struct ViewControllers {
        struct Main {
            static let title = "Home"
        }
        
        struct LandMarkDetails {
            static let path = "landMarkDetails"
            static let landMarkId = "landMarkId"
        }
        
        struct SaveLandMark {
            static let path = "saveLandMark"
        }
    }
}
