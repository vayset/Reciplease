
import Foundation

protocol FridgeServiceDelegate: class {
    func didUpdateIngredients()
    
}

class FridgeService {
    var recipesDataContainers: [RecipeDataContainer] = []

    weak var delegate: FridgeServiceDelegate?
    
    var ingredients: [String] = [] {
        didSet {
            delegate?.didUpdateIngredients()
        }
    }
    
    func getRecipes(completion: @escaping (Result<FridgeResponse, NetworkManagerError>) -> Void) {
        let networkManager = NetworkManager()
        print(recipesDataContainers.first?.recipe.image ?? "error")
        guard let recipeURL = getRecipeURL() else {
            completion(.failure(.couldNotCreateUrl))
            return
        }
        networkManager.fetch(url: recipeURL, completion: completion)

    }
    
    func getRecipeURL() -> URL? {
        var urlComponents = URLComponents()
        let ingredientsQuery = ingredients.reduce("") { (currentResult, ingredientToAppend) -> String in
            currentResult + " " + ingredientToAppend
        }
        
        urlComponents.scheme = "https"
        urlComponents.host = "api.edamam.com"
        urlComponents.path = "/search"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: ingredientsQuery),
            URLQueryItem(name: "app_id", value: "0d4f5146"),
            URLQueryItem(name: "app_key", value: "bde031a40579acca357801fcc87f4183"),
        ]
        return urlComponents.url
    }
    
    
    
    
}
