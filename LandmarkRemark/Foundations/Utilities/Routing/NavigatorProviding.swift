//
//  NavigatorProviding.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 13/6/21.
//

import UIKit

protocol NavigatorProviding {
    /// Navigates from a controller to the controller that specified in navigators.
    /// - Parameters:
    ///   - viewController: Source controller.
    ///   - transitionType: The transition type.
    ///   - parameters: The parameters to be passed when initialising controllers.
    func navigate(from viewController: UIViewController,
                  using transitionType: TransitionType,
                  parameters: [String: String])
}

extension NavigatorProviding {
    /// Navigates from source  controller to destination controller.
    /// - Parameters:
    ///   - destinationViewController: The destination view controller.
    ///   - sourceViewController: The source view controller.
    ///   - transitionType: The transition type.
    func navigate(to destinationViewController: UIViewController,
                  from sourceViewController: UIViewController,
                  using transitionType: TransitionType) {
        switch  transitionType {
        case .show:
            sourceViewController.show(destinationViewController, sender: nil)
        case .present:
            sourceViewController.present(destinationViewController, animated: true)
        }
    }
}
