
import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var recipeTitleLabel: UILabel!
    @IBOutlet private weak var recipeSubtitleLabel: UILabel!
    @IBOutlet private weak var recipeBackgroundImageView: UIImageView!
    
    
    
    func configure(recipe: Recipe) {
        recipeTitleLabel.text = recipe.label
        recipeSubtitleLabel.text = recipe.ingredientLines?.first!
        
    }


}
