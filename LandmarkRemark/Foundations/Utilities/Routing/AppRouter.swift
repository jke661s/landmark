//
//  AppRouter.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 13/6/21.
//

import UIKit

protocol AppRouterProviding {
    /// Registers navigators in a dictionary.
    /// - Parameters:
    ///   - path: A value to be saved as the key in the dictionary.
    ///   - navigator: The navigator to be saved as value.
    func register(path: String, navigator: NavigatorProviding)
    
    /// Routes between two controllers.
    /// - Parameters:
    ///   - url: A url provides information for navigator and the parameters by path and url components respectively.
    ///   - routingSource: The source view controller.
    ///   - transitionType: The transition type.
    func route(to url: URL?,
               from routingSource: RoutingSource?,
               using transitionType: TransitionType)
}

final class AppRouter: AppRouterProviding {
    // MARK: - Properties
    
    /// Shared instance
    static let shared: AppRouter = .init()
    
    /// A dictionary to get navigators by keys getting from the url path.
    private var navigators: [String: NavigatorProviding] = [:]
    
    // MARK: - AppRouterProviding conformance
    
    func register(path: String, navigator: NavigatorProviding) {
        navigators[path.lowercased()] = navigator
    }
    
    func route(to url: URL?,
               from routingSource: RoutingSource?,
               using transitionType: TransitionType) {
        guard let url = url,
              let sourceViewController = routingSource as? UIViewController ??
                UIApplication.shared.rootViewController else { return }
        let path = url.lastPathComponent.lowercased()
        guard let urlComponents = URLComponents(url: url,
                                                resolvingAgainstBaseURL: false) else { return }
        let parameters: [String: String] = (urlComponents.queryItems ?? []).reduce(into: [:]) { params, queryItem in
            params[queryItem.name.lowercased()] = queryItem.value
        }
        navigators[path]?.navigate(from: sourceViewController,
                                   using: transitionType,
                                   parameters: parameters)
    }
}
