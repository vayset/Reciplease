import UIKit

final class RecipeTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets / IBActions
    
    @IBOutlet weak var cookingTimeView: UIView!
    @IBOutlet weak var cookingTimeLabel: UILabel!
    @IBOutlet private weak var recipeTitleLabel: UILabel!
    @IBOutlet private weak var recipeSubtitleLabel: UILabel!
    @IBOutlet private weak var recipeBackgroundImageView: UIImageView!
    
    // MARK: - Internal
    
    // MARK: - Methods - Internal
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
        gradient?.frame = recipeBackgroundImageView.bounds
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        createGradientsEffect()
    }
    
    func configure(recipeDataContainer: RecipeDataContainer) {
        let recipe = recipeDataContainer.recipe
        
        if let totalTime = recipe.totalTime {
            cookingTimeLabel.text = timeConverter.formatTotaltime(totalTime)
        }
        recipeTitleLabel.text = recipe.label
        recipeSubtitleLabel.text = recipe.ingredientLines?.first
        
        if let photoData = recipeDataContainer.photo {
            recipeBackgroundImageView.image = UIImage(data: photoData)
        }
    }
    
    // MARK: - Private
    
    // MARK: - Properties - Private
    
    private let timeConverter = TimeConverter()
    private var gradient: CAGradientLayer?
    
    // MARK: - Methods - Private
    
    private func createGradientsEffect() {
        gradient = CAGradientLayer()
        gradient?.frame = recipeBackgroundImageView.bounds
        gradient?.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient?.locations = [0.2, 1.1]
        if let gradient = gradient {
            recipeBackgroundImageView.layer.addSublayer(gradient)
        }
    }
    
    private func setupUI() {
        cookingTimeView.layer.borderWidth = 1
        cookingTimeView.layer.borderColor = UIColor.white.cgColor
        cookingTimeView.layer.cornerRadius = 5
    }
    
}
