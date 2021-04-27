import Foundation
@testable import Reciplease

class NetworkManagerSuccessMock: NetworkManagerProtocol {
    func fetch<T>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void) where T : Decodable, T : Encodable {
        
        let recipe = Recipe(uri: nil, label: nil, image: nil, source: nil, url: nil, shareAs: nil, yield: nil, dietLabels: nil, ingredientLines: nil, calories: nil, totalWeight: nil, totalTime: nil)
        
        let hit = Hit(recipe: recipe, bookmarked: nil, bought: nil)
        
        let response = FridgeResponse(q: "lemon", from: nil, to: nil, more: nil, count: nil, hits: [hit])

    
        completion(.success(response as! T))
    }
    
    func fetchData(url: URL, completion: @escaping (Result<Data, NetworkManagerError>) -> Void) {
        
    }
    

    
}



class NetworkManagerFailureMock: NetworkManagerProtocol {
    func fetch<T>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void) where T : Decodable, T : Encodable {

        completion(.failure(.failedToDecodeJSON))
    }
    
    func fetchData(url: URL, completion: @escaping (Result<Data, NetworkManagerError>) -> Void) {
        
    }
    

    
}
