//
//  PlanetServiceTest.swift
//  PlanetListTaskTest
//
//  Created by Prajakta on 09/05/23.
//

import XCTest
@testable import PlanetListTask

class PlanetServiceTest: XCTestCase {
    
    let sut = PlanetViewModel()

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testToCheck_APISuccess_PlanetCountNotZero() {
        let mockurl = "testUrlString"
        sut.getPlanetList(url: mockurl, completionBlock: { _ in
            let planets = self.sut.arrPlanet
            XCTAssertTrue(planets.count > 0)
        })
    }
    
}
