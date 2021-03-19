//
//  RecipesDetailsViewController.swift
//  Reciplease
//
//  Created by Saddam Satouyev on 01/03/2021.
//

import UIKit

class RecipesDetailsViewController: UIViewController {

    var recipeDataContainer: [RecipeDataContainer] = []
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        setupUI()
    }
    
    
    private func setupUI() {
        recipeTitleLabel.text = recipeDataContainer.first?.recipe.label
        if let photoData = recipeDataContainer.first?.photo {
            print(photoData)
            recipeImageView.image = UIImage(data: photoData)
        }
       
    }
}

extension RecipesDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeDataContainer.first?.recipe.ingredientLines?.count ?? 222
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell") else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = recipeDataContainer.first?.recipe.ingredientLines![indexPath.row]
        return cell
    }

    
}

extension RecipesDetailsViewController: UITableViewDelegate {
    
}
