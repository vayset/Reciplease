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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    private func setupUI() {
        recipeTitleLabel.text = recipeDataContainer?.recipe.label
        if let photoDqtq = recipeDataContainer?.photo {
            recipeImageView.image = UIImage(data: photoDqtq)
        }
       
    }
    
   

 

}
