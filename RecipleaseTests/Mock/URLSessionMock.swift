//
//  URLSessionMock.swift
//  Le BaluchonTests
//
//  Created by Saddam Satouyev on 30/12/2020.
//

import Foundation



class UrlSessionMock: URLSession {
    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
    
    
    let data: Data?
    let response: URLResponse?
    let error: Error?
    
    
//    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
//        return UrlSessionDataTaskMock(completion: completionHandler, data: data, response: response, error: error)
//    }
}
