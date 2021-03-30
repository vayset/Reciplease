//
//  RecipesViewController.swift
//  Reciplease
//
//  Created by Saddam Satouyev on 07/02/2021.
//
import UIKit
import Foundation



class RecipesViewController: UIViewController {
    
    var recipesDataContainers: [RecipeDataContainer] = [] {
        didSet {
            DispatchQueue.main.async {
                self.recipesTableView.reloadData()
            }
            
        }
    }
    var shouldDisplayFavorites = true
    private let fridgeService = FridgeService.shared
    private let coreDataManager = RecipeCoreDataManager.shared
    
    @IBOutlet weak var recipesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipesTableView.dataSource = self
        recipesTableView.delegate = self
        
        if shouldDisplayFavorites {
            recipesDataContainers = coreDataManager.readRecipes().map {
                RecipeDataContainer(recipe: $0)
            }
        }
        
        fridgeService.fetchRecipesPhotos(recipesDataContainers: recipesDataContainers) {
            DispatchQueue.main.async {
                self.recipesTableView.reloadData()
            }
        }
        

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if
            let destinationViewController = segue.destination as? RecipesDetailsViewController,
            let recipeDataContainer = sender as? RecipeDataContainer
        {
            destinationViewController.recipeDataContainer = recipeDataContainer
        }
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
        tableView.deselectRow(at: indexPath, animated: true)
        
        let recipeDataContainer = recipesDataContainers[indexPath.row]
        performSegue(withIdentifier: "recipesList", sender: recipeDataContainer)
    }
    
}
