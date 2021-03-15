
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
        
        if let photoData = recipeDataContainer.photo {
            recipeBackgroundImageView.image = UIImage(data: photoData)
        }
        
    }

    
    
}
