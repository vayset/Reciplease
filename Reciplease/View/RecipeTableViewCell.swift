
import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var recipeTitleLabel: UILabel!
    @IBOutlet private weak var recipeSubtitleLabel: UILabel!
    @IBOutlet private weak var recipeBackgroundImageView: UIImageView! {
        didSet {
            createGradientsEffect()
        }
    }
    
    func createGradientsEffect() {
        let gradient = CAGradientLayer()
        gradient.frame = recipeBackgroundImageView.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.2, 1.1]
        recipeBackgroundImageView.layer.addSublayer(gradient)
    }
   
    func configure(recipeDataContainer: RecipeDataContainer) {

        let recipe = recipeDataContainer.recipe

        recipeTitleLabel.text = recipe.label
        recipeSubtitleLabel.text = recipe.ingredientLines?.first
        getImage(stringImage: recipe.image ?? "error")
    }

    
    func getImage(stringImage: String) {
        let imageURL = URL(string: stringImage)
        guard let imageData = try? Data(contentsOf: imageURL!) else { return }
        guard let image = UIImage(data: imageData) else { return }
        self.recipeBackgroundImageView.image = image
    }
    
}
