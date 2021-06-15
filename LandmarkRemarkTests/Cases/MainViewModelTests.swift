//
//  MainViewModelTests.swift
//  LandmarkRemarkTests
//
//  Created by Jackie Wang on 14/6/21.
//

import XCTest
@testable import LandmarkRemark

class MainViewModelTests: XCTestCase {
    var sut: MainViewModel!
    
    override func setUp() {
        super.setUp()
        sut = MainViewModel(routingSourceProvider: {
            UIViewController()
        })
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    private func updateLocationService(_ locationService: LocationServiceProviding) {
        sut = nil
        sut = MainViewModel(locationService: locationService,
                            routingSourceProvider: {
                                UIViewController()
                            })
    }
    
    func test_onLocateMeButtonTapped_getLocationResultSuccess() {
        // given
        let locationServiceMockSuccess = LocationServiceMockSuccess()
        updateLocationService(locationServiceMockSuccess)
        
        // when
        sut.onLocateMeButtonTapped()
        
        // then
        let expected = Location()
        switch sut.getLocationResult.value {
        case .success(let location):
            XCTAssertEqual(location.longitude, expected.longitude)
            XCTAssertEqual(location.latitude, expected.latitude)
            XCTAssertEqual(location.accuracy, expected.accuracy)
        case .failure:
            XCTFail("Expecting success.")
        case .none:
            XCTFail("Expecting success.")
        }
    }
    
    func test_onLocateMeButtonTapped_getLocationResultFailure() {
        // given
        let locationServiceMockFailure = LocationServiceMockFailure()
        updateLocationService(locationServiceMockFailure)
        
        // when
        sut.onLocateMeButtonTapped()
        
        // then
        let expected = LocationServiceError.notAuthorization
        switch sut.getLocationResult.value {
        case .success:
            XCTFail("Expecting failure.")
        case .failure(let error):
            XCTAssertEqual(error, expected)
        case .none:
            XCTFail("Expecting success.")
        }
    }
}
