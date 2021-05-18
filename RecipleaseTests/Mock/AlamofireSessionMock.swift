//
//  AlamofireSessionMock.swift
//  RecipleaseTests
//
//  Created by Saddam Satouyev on 04/05/2021.
//

import Foundation
import Alamofire
@testable import Reciplease

class AlamofireSessionSuccessMock: AlamofireSessionProtocol {
    func getJsonDataResponse(url: URL, completion: @escaping (AFDataResponse<Any>) -> Void) {
        let dataResponse = AFDataResponse(
            request: nil,
            response: nil,
            data: Data(),
            metrics: nil,
            serializationDuration: 1.0,
            result: .success(Data() as Any)
        )
        completion(dataResponse)
    }
    
    func getEncodableResponse<T>(url: URL, completion: @escaping (DataResponse<T, AFError>) -> Void) where T : Decodable, T : Encodable {
        let dataResponse = AFDataResponse(
            request: nil,
            response: nil,
            data: Data(),
            metrics: nil,
            serializationDuration: 1.0,
            result: .success(
                FridgeResponse(
                    q: nil,
                    from: nil,
                    to: nil,
                    more: nil,
                    count: nil,
                    hits: [
                        Hit(
                            recipe: Recipe(
                                uri: nil,
                                label: "pizza",
                                image: nil,
                                source: nil,
                                url: nil,
                                shareAs: nil,
                                yield: nil,
                                dietLabels: nil,
                                ingredientLines: nil,
                                calories: nil,
                                totalWeight: nil,
                                totalTime: nil
                            ),
                            bookmarked: nil,
                            bought: nil
                        )
                    ]
                ) as! T
            )
        )
        completion(dataResponse)
    }
}

class AlamofireSessionFailureMock: AlamofireSessionProtocol {
    func getJsonDataResponse(url: URL, completion: @escaping (AFDataResponse<Any>) -> Void) {
        let dataResponse = AFDataResponse(
            request: nil,
            response: nil,
            data: nil,
            metrics: nil,
            serializationDuration: 1.0,
            result: Result<Any, AFError>.failure(.explicitlyCancelled)
        )
        completion(dataResponse)
    }
    
    func getEncodableResponse<T>(url: URL, completion: @escaping (DataResponse<T, AFError>) -> Void) where T : Decodable, T : Encodable {
        let dataResponse = AFDataResponse(
            request: nil,
            response: nil,
            data: Data(),
            metrics: nil,
            serializationDuration: 1.0,
            result: Result<T, AFError>.failure(.explicitlyCancelled)
        )
        
        completion(dataResponse)
    }
}
