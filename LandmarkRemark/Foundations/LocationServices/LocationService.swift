//
//  LocationService.swift
//  LandmarkRemark
//
//  Created by Jackie Wang on 12/6/21.
//

import Foundation
import CoreLocation


/// Error for no location authorization.
enum LocationServiceError: Error {
    case notAuthorization
}

/// LocationService protocol
protocol LocationServiceProviding {
    typealias GetLocationCompletion = (Result<Location, LocationServiceError>) -> Void
    
    /// Fetches current locations.
    /// - Parameter completion: A call to get location or error.
    func getLocation(completion: @escaping GetLocationCompletion)
}

/// LocationService for all location related functions.
final class LocationService: NSObject, LocationServiceProviding, CLLocationManagerDelegate {
    // MARK: - Properties
    
    /// Shared instance.
    static let shared = LocationService()
    
    /// Call back when successfully gets locations. The reason to do so is
    /// because location would be returned in `didUpdateLocations` function rather than `getLocation`.
    fileprivate var getLocationCompletion: GetLocationCompletion?
    
    /// LocationManager to check authorization and fetch locations.
    fileprivate var locationManager: CLLocationManager
    
    // MARK: - Life cycle
    
    /// Initialized a locationService.
    /// - Parameter locationManager: A CLLocationManager passed in. Default value is `CLLocationManager()`
    init(_ locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - LocationServiceProviding conformance
    
    /// Fetches current locations.
    /// - Parameter completion: A call to get location or error.
    func getLocation(completion: @escaping GetLocationCompletion) {
        getLocationCompletion = completion
        locationManager.startUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate conformance
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            getLocationCompletion?(.failure(.notAuthorization))
            getLocationCompletion = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        guard let location = locations.first else {
            getLocationCompletion?(.failure(.notAuthorization))
            getLocationCompletion = nil
            return
        }
        getLocationCompletion?(.success(Location(location)))
        getLocationCompletion = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(Strings.Error.failToGetLocation + "\(error)")
        locationManager.stopUpdatingLocation()
        getLocationCompletion?(.failure(.notAuthorization))
        getLocationCompletion = nil
    }
}
