import Foundation
@testable import Reciplease

class NetworkManagerMock: NetworkManagerProtocol {
    func fetch<T>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void) where T : Decodable, T : Encodable {
        let response = FridgeResponse(q: "lemon", from: nil, to: nil, more: nil, count: nil, hits: nil)

    
        
        completion(.success(response as! T))
    }
    
    func fetchData(url: URL, completion: @escaping (Result<Data, NetworkManagerError>) -> Void) {
        
    }
    

    
}
