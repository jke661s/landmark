//
//  SaveLandmarkNavigator.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 13/6/21.
//

import UIKit

/// A navigator for SaveLandmarkController
struct SaveLandmarkNavigator: NavigatorProviding {
    // MARK: - NavigatorProviding conformance
    
    func navigate(from viewController: UIViewController,
                  using transitionType: TransitionType,
                  parameters: [String : String]) {
        let key = Strings.ViewControllers.SaveLandmark.location
        guard let location = UserDefaults.standard.retrieveAndDelete(object: Location.self, fromKey: key) else {
            return
        }
        let destinationViewController = SaveLandmarkViewController(location: location)
        navigate(to: destinationViewController,
                 from: viewController,
                 using: transitionType)
    }
}
