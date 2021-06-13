//
//  MainViewModel.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 13/6/21.
//

import Foundation

protocol MainViewModelProviding {
    /// Title of MainViewController
    var title: String { get }
    
    /// A value for location or error, binding with controller.
    var getLocationResult: Bindable<Result<Location, LocationServiceError>> { get }
    
    /// The action when location me button is tapped.
    func onLocateMeButtonTapped()
    
    /// The action when remark button is tapped.
    func onRemarkButtonTapped()
}

struct MainViewModel: MainViewModelProviding {
    // MARK: - Properties
    
    let title = Strings.ViewControllers.Main.title
    let getLocationResult = Bindable<Result<Location, LocationServiceError>>()
    
    private let locationService: LocationServiceProviding = LocationService.shared
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
    
    func onRemarkButtonTapped() {
        locationService.getLocation { result in
            switch result {
            case .success(let location):
                UserDefaults.standard.save(customObject: location,
                                           inKey: Strings.ViewControllers.SaveLandmark.location)
                DispatchQueue.main.async {
                    router.route(to: URL(string: "\(UniversalLinks.baseURL)\(Strings.ViewControllers.SaveLandmark.path)"),
                                 from: routingSourceProvider(),
                                 using: .present)
                }
            case .failure(let error):
                getLocationResult.value = .failure(error)
            }
        }
        
        
    }
}
