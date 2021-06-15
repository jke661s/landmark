//
//  LocationServiceTests.swift
//  LandmarkRemarkTests
//
//  Created by Jackie Wang on 14/6/21.
//

import XCTest
@testable import LandmarkRemark

class LocationServiceTests: XCTestCase {
    var sut: LocationServiceProviding!
    
    override func setUp() {
        super.setUp()
        sut = LocationService.shared
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testService_getLocation_getResult() {
        sut.getLocation { result in
            XCTAssertNotNil(result)
        }
    }
}
