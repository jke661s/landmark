//
//  MainViewController.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 12/6/21.
//

import UIKit
import MapKit

final class MainViewController: BaseViewController, AlertDisplay {
    // MARK: - Properties
    
    /// MainViewController viewModel.
    private var viewModel: MainViewModelProviding!
    
    /// A map view displaying the user's location.
    private let mapView: MKMapView = configure(MKMapView()) {
        $0.showsUserLocation = true
    }
    
    /// A button to locate the user.
    private let locateMeButton: UIButton = configure(UIButton(type: .system)) {
        let configuration = UIImage.SymbolConfiguration(pointSize: 30)
        let image = UIImage(systemName: "record.circle", withConfiguration: configuration)
        $0.setImage(image, for: .normal)
        $0.addTarget(self, action: #selector(onLocateMeButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Life cycle
    
    init(router: AppRouterProviding = AppRouter.shared) {
        super.init()
        viewModel = MainViewModel(router: router,
                                  routingSourceProvider: { [weak self] in
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
        view.backgroundColor = .systemBackground
        title = viewModel.title
        view.addSubview(mapView)
        view.addSubview(locateMeButton)
    }
    
    private func setupConstraints() {
        // mapView constraints
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // locateMeButton constraints
        NSLayoutConstraint.activate([
            locateMeButton.widthAnchor.constraint(equalToConstant: 50),
            locateMeButton.heightAnchor.constraint(equalToConstant: 50),
            locateMeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            locateMeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
    }
    
    private func setupBindings() {
        // Zoom in to locate the user or display an alter
        viewModel.getLocationResult.bind { [weak self] result in
            guard let self = self, let result = result else { return }
            switch result {
            case .success(let location):
                let center = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
                let coordinateRegion = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
                DispatchQueue.main.async {
                    self.mapView.setRegion(coordinateRegion, animated: true)
                }
            case .failure:
                self.showPermissionError(errorType: .location) { _ in
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                          UIApplication.shared.canOpenURL(settingsUrl) else { return }
                    DispatchQueue.main.async {
                        UIApplication.shared.open(settingsUrl)
                    }
                }
            }
        }
    }
    
    // MARK: - Button events
    @objc private func onLocateMeButtonTapped() {
        viewModel.onLocateMeButtonTapped()
    }
}
 
