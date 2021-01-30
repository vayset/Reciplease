
import Foundation


class FridegeService {
    
    
    func getRecipe(ingredient: String, completion: @escaping (Result<FridgeResponse, NetworkManagerError>) -> Void) {
        let networkManager = NetworkManager()
        
        guard let recipeURL = getRecipeURL(ingredient: ingredient) else {
            completion(.failure(.couldNotCreateUrl))
            return
            
        }
        
        networkManager.fetch(url: recipeURL, completion: completion)
    }
    
    
    func getRecipeURL(ingredient: String) -> URL? {
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "http"
        urlComponents.host = "api.edamam.com"
        urlComponents.path = "/search"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: ingredient),
            URLQueryItem(name: "app_id", value: "0d4f5146"),
            URLQueryItem(name: "app_key", value: "bde031a40579acca357801fcc87f4183"),
        ]
        return urlComponents.url
    }
    
    
    
    
}
