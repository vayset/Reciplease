
import Foundation

protocol FridgeServiceDelegate: class {
    func didUpdateIngredients()
    
}

enum FridgeServiceError: Error {
    case failedToAddIngredientIsEmpty
    case failedToAddIngredientIsTooBig
    case failedToGetRecipesIngredientIsEmpty
    case failedToGetRecipesBackendError
    case couldNotCreateUrl
}

class FridgeService {
    static let shared = FridgeService()
    
    init(
        networkManager: NetworkManagerProtocol = AlamofireNetworkManager(),
        urlComponents: UrlComponentsProtocol = URLComponents()
    ) {
        self.networkManager = networkManager
        self.urlComponents = urlComponents
    }
    
    var recipesDataContainers: [RecipeDataContainer] = []
    
    weak var delegate: FridgeServiceDelegate?
    
    private let networkManager: NetworkManagerProtocol
    
    var ingredients: [String] = [] {
        didSet {
            delegate?.didUpdateIngredients()
        }
    }
    
    
    func addIngredient(_ ingredient: String) -> Result<Void, FridgeServiceError> {
        guard !ingredient.trimmingCharacters(in: .whitespaces).isEmpty else {
            return .failure(.failedToAddIngredientIsEmpty)
        }
        ingredients.append(ingredient)
        return .success(())
    }
    
    func getRecipes(completion: @escaping (Result<[Recipe], FridgeServiceError>) -> Void) {
        guard !ingredients.isEmpty else {
            completion(.failure(.failedToGetRecipesIngredientIsEmpty))
            return
        }
        
        guard let recipeURL = getRecipeURL() else {
            completion(.failure(.couldNotCreateUrl))
            return
        }
        
        networkManager.fetch(url: recipeURL) { (result: Result<FridgeResponse, NetworkManagerError>) in
            switch result {
            case .failure:
                completion(.failure(.failedToGetRecipesBackendError))
                return
            case .success(let fridgeResponse):
                
                let recipes = fridgeResponse.hits.compactMap({$0.recipe})
                
                completion(.success(recipes))
                return
            }
            
        }
    }
    
    
    private var urlComponents: UrlComponentsProtocol
    
    func getRecipeURL() -> URL? {
    
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
