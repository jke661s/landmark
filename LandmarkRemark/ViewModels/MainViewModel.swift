//
//  MainViewModel.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 13/6/21.
//

import Foundation

protocol MainViewModelProviding {
    var title: String { get }
    var getLocationResult: Bindable<Result<Location, LocationServiceError>> { get }
    func onLocateMeButtonTapped()
}

struct MainViewModel: MainViewModelProviding {
    // MARK: - Properties
    
    let title = Strings.ViewControllers.Main.title
    let getLocationResult = Bindable<Result<Location, LocationServiceError>>()
    
    private let locationService: LocationServiceProviding = LocationService()
    private let router: AppRouterProviding
    private let routingSourceProvider: RoutingSourceProvider
    
    // MARK: - Life cycle
    
    init(router: AppRouterProviding, routingSourceProvider: @escaping RoutingSourceProvider) {
        self.router = router
        self.routingSourceProvider = routingSourceProvider
    }
    
    // MARK: - MainViewModelProviding conformance
    
    func onLocateMeButtonTapped() {
        locationService.getLocation { result in
            switch result {
            case .success(let location):
                getLocationResult.value = .success(location)
            case .failure(let error):
                getLocationResult.value = .failure(error)
            }
        }
    }
}
