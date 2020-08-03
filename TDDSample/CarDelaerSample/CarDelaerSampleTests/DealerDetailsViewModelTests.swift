//
//  DealerDetailsViewModelTests.swift
//  CarDelaerSampleTests
//
//  Created by Sachin Bhardwaj on 30/01/20.
//  Copyright © 2020 Sachin Bhardwaj. All rights reserved.
//

import Foundation

import XCTest
@testable import CarDelaerSample

class DealerDetailsViewModelTests: XCTestCase {
    override func setUp() { }
    
    func testGetCarModelAndYear() {
        let subject = DealerDetailViewModel(dealerDetailsWebService: MockDealerDetailsWebService())
        let str = subject.getCarModelAndYear(carPriceDetails: (year: 2010, carMake: "TestMake", carModel: "TestModel"))
        XCTAssertEqual(str, "2010 TestMake TestModel")
    }
    
    func testGetCarPriceMileAndAddress() {
        let subject = DealerDetailViewModel(dealerDetailsWebService: MockDealerDetailsWebService())
        let str = subject.getCarPriceMileAndAddress(carMake: (price: 100,
                                                              carMileage: 200,
                                                              dealerCity: "TestCity",
                                                              dealerState: "VA"))
        XCTAssertEqual(str, "$100 | 200 Mi | TestCity,VA")
        
    }
}

struct MockDealerDetailsWebService: DealerDetailsWebservicable {
    
    func getDealerData(completion: @escaping (CarDetails) -> Void) {
        let mockSession = NetworkSessionMock()
        guard let url = URL(string: "XXXX.com") else { return }
        mockSession.getApiCall(url: url) { (data, response, error) in
            
        }
    }
}

