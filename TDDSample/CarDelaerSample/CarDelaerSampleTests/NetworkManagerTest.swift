//
//  NetworkManagerTest.swift
//  CarDelaerSampleTests
//
//  Created by Sachin Bhardwaj on 29/01/20.
//  Copyright © 2020 Sachin Bhardwaj. All rights reserved.
//

import XCTest
@testable import CarDelaerSample

class NetworkManagerTest: XCTestCase {
    override func setUp() { }
    
    func testGetApiCall() {
        guard let url = URL(string: "XXXX.com") else { return }
        
        let subject = NetworkSessionMock()
        
        let bundle = Bundle(for: type(of: self))
        guard let file = bundle.url(forResource: "GetCallResponse", withExtension: "json") else { return }
        let expectedData = try! Data(contentsOf:file)

        let expectation = self.expectation(description: "Getting data for dealer")

        subject.getApiCall(url: url) { (data, response, error) in
           expectation.fulfill()
            XCTAssertEqual(data, expectedData)
        }
        waitForExpectations(timeout: 0.1)
    }
}

class NetworkSessionMock: NetworkSession {
    var error: Error?
    var response: URLResponse?
    
    func getApiCall(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let bundle = Bundle(for: type(of: self))
        guard let file = bundle.url(forResource: "GetCallResponse", withExtension: "json") else { return }
        let responseData = try! Data(contentsOf:file)
        completion(responseData, response, error)
    }
}
