//
//  SaveLandMarkNavigator.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 13/6/21.
//

import UIKit

/// A navigator for SaveLandmarkController
struct SaveLandMarkNavigator: NavigatorProviding {
    // MARK: - NavigatorProviding conformance
    
    func navigate(from viewController: UIViewController,
                  using transitionType: TransitionType,
                  parameters: [String : String]) {
        let navigationController = UINavigationController(rootViewController: SaveLandMarkViewController())
        navigate(to: navigationController,
                 from: viewController,
                 using: transitionType)
    }
}
