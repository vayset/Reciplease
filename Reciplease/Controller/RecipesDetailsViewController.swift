//
//  RecipesDetailsViewController.swift
//  Reciplease
//
//  Created by Saddam Satouyev on 01/03/2021.
//

import UIKit

class RecipesDetailsViewController: UIViewController {

    var recipeDataContainer: RecipeDataContainer?
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var getDirectionsOutlet: UIButton!
    @IBOutlet weak var favoriteBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var cookingTimeLabel: UILabel!
    @IBOutlet weak var cookingTimeView: UIView!
    
    let timeConverter = TimeConverter()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        setupUI()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateFavoriteBarButtonIcon()
    }
    
    @IBAction func getDirectionsUIButton(_ sender: Any) {
        
        if
            let urlString = recipeDataContainer?.recipe.url,
            let url = URL(string: urlString) {
                
            UIApplication.shared.open(url)
        }
    }
    
    var gradient: CAGradientLayer?
    
    func createGradientsEffect() {
        let colorBrown = UIColor(red: 57/255, green: 51/255, blue: 50/255, alpha: 1.0)
        gradient = CAGradientLayer()
        gradient?.frame = recipeImageView.bounds
        gradient?.colors = [UIColor.clear.cgColor, colorBrown.cgColor]
        gradient?.frame = recipeImageView.bounds
        gradient?.locations = [0.2, 1.1]
        if let gradient = gradient {
            recipeImageView.layer.addSublayer(gradient)
        }
    }
    
    @IBAction func didTapFavoriteButton(_ sender: Any) {
        guard let recipeToFavoriteContainer = recipeDataContainer else { return }
        
        if !getIsRecipeFavorited(recipe: recipeToFavoriteContainer.recipe) {
            coreDataManager.createRecipe(recipeDataContainer: recipeToFavoriteContainer)
        } else {
            coreDataManager.deleteRecipe(with: recipeToFavoriteContainer.recipe.label!)
        }
        updateFavoriteBarButtonIcon()
    }
    
    private func updateFavoriteBarButtonIcon() {
        guard let recipeToFavoriteContainer = recipeDataContainer else { return }
        
        if getIsRecipeFavorited(recipe: recipeToFavoriteContainer.recipe) {
            favoriteBarButtonItem.image = UIImage(systemName: "star.fill")
        } else {
            favoriteBarButtonItem.image = UIImage(systemName: "star")
        }
        
    }
    
    
    private func getIsRecipeFavorited(recipe: Recipe) -> Bool {
        
        let storedRecipes = coreDataManager.readRecipes()
        
        for recipeDataContainer in storedRecipes where recipeDataContainer.recipe.label == recipe.label {
            return true
        }
        
        return false
    }
    
    private func setupUI() {
        recipeTitleLabel.text = recipeDataContainer?.recipe.label
        if let photoData = recipeDataContainer?.photo {
            print(photoData)
            recipeImageView.image = UIImage(data: photoData)
        }
        getDirectionsOutlet.layer.cornerRadius = 5
        createGradientsEffect()
        
        cookingTimeView.layer.borderWidth = 1
        cookingTimeView.layer.borderColor = UIColor.white.cgColor
        cookingTimeView.layer.cornerRadius = 5
    }
    
    func configure() {
        let recipe = recipeDataContainer?.recipe
        
        if let totalTime = recipe?.totalTime {
            cookingTimeLabel.text = timeConverter.formatTotaltime(totalTime)
            print(totalTime)
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradient?.frame = recipeImageView.bounds
        
    }
    
    
    private let coreDataManager = RecipeCoreDataManager.shared

}

extension RecipesDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeDataContainer?.recipe.ingredientLines?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell") else {
            return UITableViewCell()
        }
        let cellText = "- \(recipeDataContainer?.recipe.ingredientLines![indexPath.row] ?? "Error")"
        

        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "Chalkduster", size: 15.0)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = cellText
        return cell
    }

    
}

extension RecipesDetailsViewController: UITableViewDelegate {
    
}
