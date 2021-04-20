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
                self.noRecipeLabel.isHidden = !self.recipesDataContainers.isEmpty
            }
            
        }
    }
    var shouldDisplayFavorites = true
    private let fridgeService = FridgeService.shared
    private let coreDataManager = RecipeCoreDataManager.shared
    private let alertManagerController = AlertManagerController.shared
    
    @IBOutlet weak var noRecipeLabel: UILabel!
    @IBOutlet weak var recipesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipesTableView.dataSource = self
        recipesTableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if shouldDisplayFavorites {
            if coreDataManager.readRecipes().isEmpty {
                alertManagerController.presentSimpleAlert(from: self, message: "You have not ingredients in the favorite")
            }
            recipesDataContainers = coreDataManager.readRecipes().reversed()
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
