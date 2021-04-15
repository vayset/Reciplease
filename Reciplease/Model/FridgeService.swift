
import Foundation

protocol FridgeServiceDelegate: class {
    func didUpdateIngredients()
    
}

class FridgeService {
    static let shared = FridgeService()
    
    var recipesDataContainers: [RecipeDataContainer] = []

    weak var delegate: FridgeServiceDelegate?
    
    private let networkManager = NetworkManager()
    
    var ingredients: [String] = [] {
        didSet {
            delegate?.didUpdateIngredients()
        }
    }
    
    func getRecipes(completion: @escaping (Result<FridgeResponse, NetworkManagerError>) -> Void) {
        guard !ingredients.isEmpty else {
            completion(.failure(.unknownError))
            return
        }
        
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
    
    
    
    func fetchRecipesPhotos(recipesDataContainers: [RecipeDataContainer], completion: @escaping () -> Void) {
        for recipesDataContainer in recipesDataContainers {
            guard
                let recipeImageUrlString = recipesDataContainer.recipe.image,
                let recipeImageUrl = URL(string: recipeImageUrlString)
                else {
                continue
            }
            networkManager.fetchData(url: recipeImageUrl) { (result) in
                switch result {
                case .success(let imageData):
                    recipesDataContainer.photo = imageData
                    completion()
                case .failure(let error):
                    print("Could not fetch recipe photo data with error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    
    
}
