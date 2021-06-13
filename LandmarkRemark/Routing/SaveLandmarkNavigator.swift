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
        let destinationViewController = SaveLandmarkViewController()
        navigate(to: destinationViewController,
                 from: viewController,
                 using: transitionType)
    }
}
