//
//  RoutingSource.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 13/6/21.
//

import UIKit

/// Decoupling UIViewControllers in `route` function in AppRouter.
protocol RoutingSource { }

/// Uses call back to avoid duplicating declaring `weak` in view models.
typealias RoutingSourceProvider = () -> RoutingSource?

extension UIViewController: RoutingSource { }
