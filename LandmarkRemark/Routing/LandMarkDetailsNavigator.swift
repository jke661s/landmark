//
//  LandMarkDetailsNavigator.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 13/6/21.
//

import UIKit

/// A navigator for SaveLandmarkController
struct LandMarkDetailsNavigator: NavigatorProviding {
    // MARK: - NavigatorProviding conformance
    
    func navigate(from viewController: UIViewController, using transitionType: TransitionType, parameters: [String : String]) {
        guard let landMarkId = parameters[Strings.ViewControllers.LandMarkDetails.landMarkId] else { return }
        // init LandMarkDetailsController by landMarkId
    }
}
