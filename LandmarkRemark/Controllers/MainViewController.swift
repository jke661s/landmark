//
//  MainViewController.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 12/6/21.
//

import UIKit
import MapKit

final class MainViewController: BaseViewController {
    // MARK: - Properties
    
    private var viewModel: MainViewModelProviding!
    private var mapView = MKMapView()
    
    // MARK: - Life cycle
    
    init(router: AppRouterProviding = AppRouter.shared) {
        super.init()
        viewModel = MainViewModel(router: router, routingSourceProvider: { [weak self] in
            self
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupBindings()
    }
    
    // MARK: - Private functions
    private func setupViews() {
        title = viewModel.title
        
        mapView.showsUserLocation = true
    }
    
    private func setupConstraints() {
        
    }
    
    private func setupBindings() {
        
    }
}
 
