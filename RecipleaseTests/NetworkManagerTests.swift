//
//  NetworkManagerTests.swift
//  RecipleaseTests
//
//  Created by Saddam Satouyev on 03/05/2021.
//

import XCTest
@testable import Reciplease

class NetworkManagerTests: XCTestCase {
    
    func test_given_whenFetch_thenSuccess() {
        
        let alamafireSessionMock = AlamofireSessionSuccessMock()
        let networkManager = AlamofireNetworkManager(session: alamafireSessionMock)
        
        let fakeUrl = URL(string: "www.google.com")!
        
        networkManager.fetch(url: fakeUrl) { (result: Result<FridgeResponse, NetworkManagerError>) in
            switch result {
            case .failure:
                XCTFail("ERROR")
            case .success(let response):
                XCTAssertEqual(response.hits.first!.recipe!.label, "pizza")
            }
        }
        
    }
    
    func test_given_whenFetch_thenFailure() {
        
        let alamafireSessionMock = AlamofireSessionFailureMock()
        let networkManager = AlamofireNetworkManager(session: alamafireSessionMock)
        
        let fakeUrl = URL(string: "www.google.com")!
        
        networkManager.fetch(url: fakeUrl) { (result: Result<FridgeResponse, NetworkManagerError>) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .failedToDecodeJSON)
            case .success:
                XCTFail("ERROR")
            }
        }
    }
    
    func test_given_whenFetchData_thenSuccess() {
        
        let alamafireSessionMock = AlamofireSessionSuccessMock()
        let networkManager = AlamofireNetworkManager(session: alamafireSessionMock)
        
        let fakeUrl = URL(string: "www.google.com")!
        
        networkManager.fetchData(url: fakeUrl) { result in
            switch result {
            case .failure: XCTFail("ERROR")
            case .success:
                XCTAssert(true)
            }
        }
        
    }
        
    func test_given_whenFetchData_thenFailure() {
        
        let alamafireSessionMock = AlamofireSessionFailureMock()
        let networkManager = AlamofireNetworkManager(session: alamafireSessionMock)
        
        let fakeUrl = URL(string: "www.google.com")!
        
        networkManager.fetchData(url: fakeUrl) { result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .noData)
                
            case .success:
                XCTFail("ERROR")
            }
        }
        
    }
}
