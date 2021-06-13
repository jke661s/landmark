//
//  AppDelegate.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 12/6/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        onLaunch()
        return true
    }
}

private extension AppDelegate {
    func onLaunch() {
        let router: AppRouterProviding = AppRouter.shared
        
        router.register(path: Strings.ViewControllers.SaveLandmark.path, navigator: SaveLandmarkNavigator())
        router.register(path: Strings.ViewControllers.LandmarkDetails.path, navigator: LandmarkDetailsNavigator())
    }
}

