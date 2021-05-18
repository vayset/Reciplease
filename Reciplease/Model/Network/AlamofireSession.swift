//
//  AlamofireSession.swift
//  Reciplease
//
//  Created by Saddam Satouyev on 04/05/2021.
//

import Foundation
import Alamofire

protocol AlamofireSessionProtocol {
    func getEncodableResponse<T: Codable>(url: URL, completion: @escaping (DataResponse<T, AFError>) -> Void)
    func getJsonDataResponse(url: URL, completion: @escaping (AFDataResponse<Any>) -> Void)
}

class AlamofireSession: AlamofireSessionProtocol {
    func getJsonDataResponse(url: URL, completion: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(url).responseJSON(completionHandler: completion)
    }
    
    func getEncodableResponse<T>(url: URL, completion: @escaping (DataResponse<T, AFError>) -> Void) where T : Decodable, T : Encodable {
        AF.request(url).responseDecodable(completionHandler: completion)
    }
    
}
