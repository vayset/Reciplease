import Foundation
@testable import Reciplease


struct UrlComponentsMock: UrlComponentsProtocol {
    var scheme: String? = ""
    
    var host: String? = ""
    
    var path: String = ""
    
    var queryItems: [URLQueryItem]? = []
    
    var url: URL? = nil
    
    
}

