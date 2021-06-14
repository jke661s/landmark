//
//  MainNavigator.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 14/6/21.
//

import UIKit

/// A navigator for MainViewController
struct MainNavigator: NavigatorProviding {
    // MARK: - NavigatorProviding conformance
    
    func navigate(from viewController: UIViewController,
                  using transitionType: TransitionType,
                  parameters: [String : String]) {
        let destinationViewController = MainViewController()
        let navigationController = UINavigationController(rootViewController: destinationViewController)
        navigate(to: navigationController,
                 from: viewController,
                 using: transitionType)
    }
}
