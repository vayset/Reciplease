//
//  RecipesViewController.swift
//  Reciplease
//
//  Created by Saddam Satouyev on 07/02/2021.
//
import UIKit
import Foundation


class RecipeDataContainer {
    init(recipe: Recipe, photo: UIImage? = nil) {
        self.recipe = recipe
        self.photo = photo
    }
    
    let recipe: Recipe
    var photo: UIImage?
}

class RecipesViewController: UIViewController {
    
    var recipesDataContainers: [RecipeDataContainer] = []
    
    @IBOutlet weak var recipesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipesTableView.dataSource = self
        recipesTableView.delegate = self
    }
    
    
}

extension RecipesViewController: UITableViewDataSource  {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesDataContainers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell") as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        
        let recipeDataContainer = recipesDataContainers[indexPath.row]
        
        cell.configure(recipeDataContainer: recipeDataContainer)
        
        return cell
    }
    
}

extension RecipesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
