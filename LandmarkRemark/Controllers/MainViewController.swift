//
//  MainViewController.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 12/6/21.
//

import UIKit
import MapKit

final class MainViewController: BaseViewController, AlertDisplay, MKMapViewDelegate {
    // MARK: - Properties
    
    /// MainViewController viewModel.
    private var viewModel: MainViewModelProviding!
    
    /// A map view displaying the user's location.
    private lazy var mapView: MKMapView = configure(MKMapView()) {
        $0.showsUserLocation = true
        $0.delegate = self
    }
    
    /// A button to locate the user.
    private let locateMeButton: CircleButton = configure(CircleButton(image: .recordCircle)) {
        $0.addTarget(self, action: #selector(onLocateMeButtonTapped), for: .touchUpInside)
    }
    
    private let remarkButton: CircleButton = configure(CircleButton(image: .rCircle)) {
        $0.addTarget(self, action: #selector(onRemarkButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Life cycle
    
    override init() {
        super.init()
        viewModel = MainViewModel(routingSourceProvider: { [weak self] in
            self
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    // MARK: - Private functions
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = true
        title = viewModel.title
        view.addSubview(mapView)
        view.addSubview(remarkButton)
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
            locateMeButton.widthAnchor.constraint(equalToConstant: ConstraintConstants.CircleButton.width),
            locateMeButton.heightAnchor.constraint(equalToConstant: ConstraintConstants.CircleButton.height),
            locateMeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                   constant: -ConstraintConstants.Padding.medium),
            locateMeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                     constant: -ConstraintConstants.Padding.medium)
        ])
        
        // remarkButton constraints
        NSLayoutConstraint.activate([
            remarkButton.widthAnchor.constraint(equalToConstant: ConstraintConstants.CircleButton.width),
            remarkButton.heightAnchor.constraint(equalToConstant: ConstraintConstants.CircleButton.width),
            remarkButton.bottomAnchor.constraint(equalTo: locateMeButton.topAnchor, constant: -ConstraintConstants.Padding.medium),
            remarkButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ConstraintConstants.Padding.medium)
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
        
        // Update the map view when data source got updated.
        viewModel.landmarkDataSource.bind { [weak self] landmarks in
            guard let self = self, let landmarks = landmarks else { return }
            self.removeAllAnnotation()
            landmarks.forEach {
                self.addAnnotation($0)
            }
        }
    }
    
    private func addAnnotation(_ landmark: Landmark) {
        let annotation = MKPointAnnotation()
//        annotation.description = landmark.description
        annotation.subtitle = landmark.username
        annotation.title = landmark.landMarkDescription
        annotation.coordinate = CLLocationCoordinate2D(latitude: landmark.location?.latitude ?? 0, longitude: landmark.location?.longitude ?? 0)
        mapView.addAnnotation(annotation)
    }
    
    private func removeAllAnnotation() {
        for annotation in self.mapView.annotations {
            self.mapView.removeAnnotation(annotation)
        }
    }
    
    // MARK: - Button events
    @objc private func onLocateMeButtonTapped() {
        viewModel.onLocateMeButtonTapped()
    }
    
    @objc private func onRemarkButtonTapped() {
        viewModel.onRemarkButtonTapped()
    }
    
    // MARK: - MKMapViewDelegate conformance
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }
}
 
