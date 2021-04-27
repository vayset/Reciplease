//
//  UrlComponentsProtocol.swift
//  Reciplease
//
//  Created by Saddam Satouyev on 27/04/2021.
//



import Foundation

protocol UrlComponentsProtocol {
    var scheme: String? { get set }
    var host: String? { get set }
    var path: String { get set }
    var queryItems: [URLQueryItem]? { get set }
    var url: URL? { get }
}

extension URLComponents: UrlComponentsProtocol { }


