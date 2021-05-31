import Foundation

protocol FridgeServiceDelegate: class {
    func didUpdateIngredients()    
}

final class FridgeService {
    // MARK: - Internal
    
    // MARK: - Properties - Internal
    
    static let shared = FridgeService()
    weak var delegate: FridgeServiceDelegate?
    var ingredients: [String] = [] {
        didSet {
            delegate?.didUpdateIngredients()
        }
    }

    // MARK: - Methods - Internal
    
    init(
        networkManager: AlamofireNetworkManagerProtocol = AlamofireNetworkManager(),
        urlComponents: UrlComponentsProtocol = URLComponents()
    ) {
        self.networkManager = networkManager
        self.urlComponents = urlComponents
    }

    /// "Tomato, Cheese, Lemon"
    ///=> ["Tomato", "Cheese", "Lemon"]
    /// 1. tomato
    /// 2. retire les blanc et met le tout en miniscule
    /// 3. Check que pas vide
    /// 4. Check que le tableau d'ingrédient ne continet PAS deja l'ingrédient à ajouter
    /// 5. Ajoute
    func addIngredient(_ ingredientsAsSingleString: String) -> Result<Void, FridgeServiceError> {
        
        let ingredientsSplit = ingredientsAsSingleString.split(separator: ",")
        
        for ingredient in ingredientsSplit {
            let trimmedIngredient = ingredient.trimmingCharacters(in: .whitespaces).lowercased()
            
            guard !trimmedIngredient.isEmpty else {
                return .failure(.failedToAddIngredientIsEmpty)
            }
            
            guard !ingredients.contains(trimmedIngredient) else {
                return .failure(.failedToAddIngredientIsAlreadyAdded)
            }
            
            ingredients.append(trimmedIngredient)
        }
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
            URLQueryItem(name: "app_key", value: "bde031a40579acca357801fcc87f4183")
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
    
    // MARK: - Private
    
    // MARK: - Properties - Private
    
    private var recipesDataContainers: [RecipeDataContainer] = []
    private let networkManager: AlamofireNetworkManagerProtocol
    private var urlComponents: UrlComponentsProtocol
    
}
