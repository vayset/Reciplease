//
//  RecipesDetailsViewController.swift
//  Reciplease
//
//  Created by Saddam Satouyev on 01/03/2021.
//

import UIKit

class RecipesDetailsViewController: UIViewController {
//    var recipeDataContainer: RecipeDataContainer?
    var recipeDataContainer: [RecipeDataContainer] = []
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
    }
    
    
    private func setupUI(recipeDataContainer: RecipeDataContainer) {
        recipeTitleLabel.text = recipeDataContainer.first?.recipe.label
        if let photoData = recipeDataContainer.first?.photo {
            recipeImageView.image = UIImage(data: photoData)
        }
       
    }

}

extension RecipesDetailsViewController: UITableViewDataSource {
    // 1
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // 2
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeDataContainer.count
    }

    // 3
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath)

        cell.textLabel?.text = recipeDataContainer.first?.recipe.label
        cell.textLabel?.text = recipeDataContainer.first?.recipe.source
        cell.textLabel?.text = recipeDataContainer.first?.recipe.source
        cell.textLabel?.text = recipeDataContainer.first?.recipe.source
        cell.textLabel?.text = recipeDataContainer.first?.recipe.source
        cell.textLabel?.text = recipeDataContainer.first?.recipe.source



        return cell
    }
    
    
    
}

extension RecipesDetailsViewController: UITableViewDelegate {
    
}
