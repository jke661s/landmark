//
//  LocationServiceMock.swift
//  LandmarkRemarkTests
//
//  Created by Jackie Wang on 15/6/21.
//

import Foundation
@testable import LandmarkRemark

final class LocationServiceMockSuccess: LocationServiceProviding {
    func getLocation(completion: @escaping GetLocationCompletion) {
        completion(.success(Location()))
    }
}

final class LocationServiceMockFailure: LocationServiceProviding {
    func getLocation(completion: @escaping GetLocationCompletion) {
        completion(.failure(.notAuthorization))
    }
}
