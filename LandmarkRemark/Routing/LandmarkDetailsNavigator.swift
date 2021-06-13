//
//  LandmarkDetailsNavigator.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 13/6/21.
//

import UIKit

/// A navigator for SaveLandmarkController
struct LandmarkDetailsNavigator: NavigatorProviding {
    // MARK: - NavigatorProviding conformance
    
    func navigate(from viewController: UIViewController, using transitionType: TransitionType, parameters: [String : String]) {
        guard let landMarkId = parameters[Strings.ViewControllers.LandmarkDetails.landMarkId] else { return }
        // init LandmarkDetailsController by landMarkId
    }
}
