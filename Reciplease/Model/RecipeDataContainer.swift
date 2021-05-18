import Foundation

class RecipeDataContainer {
    init(recipe: Recipe, photo: Data? = nil) {
        self.recipe = recipe
        self.photo = photo
    }
    
    let recipe: Recipe
    var photo: Data?
}
