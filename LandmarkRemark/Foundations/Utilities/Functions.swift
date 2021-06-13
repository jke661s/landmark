//
//  Functions.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 13/6/21.
//

import UIKit

/// Initializes, configures and gets an object.
/// - Parameters:
///   - object: The object to be initialized.
///   - closure: The configuration to the object.
/// - Returns: An object configured well.
func configure<T: UIView>(_ object: T, closure: (T) -> Void) -> T {
    object.translatesAutoresizingMaskIntoConstraints = false
    closure(object)
    return object
}
