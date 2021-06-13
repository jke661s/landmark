//
//  MainViewModel.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 13/6/21.
//

import Foundation

protocol MainViewModelProviding {
    var title: String { get }
}

struct MainViewModel: MainViewModelProviding {
    // MARK: - Properties
    let title = Strings.ViewControllers.Main.title
    
    private let router: AppRouterProviding
    private let routingSourceProvider: RoutingSourceProvider
    
    // MARK: - Life cycle
    
    init(router: AppRouterProviding, routingSourceProvider: @escaping RoutingSourceProvider) {
        self.router = router
        self.routingSourceProvider = routingSourceProvider
    }
}
