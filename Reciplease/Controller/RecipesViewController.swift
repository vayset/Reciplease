//
//  RecipesViewController.swift
//  Reciplease
//
//  Created by Saddam Satouyev on 07/02/2021.
//
import UIKit
import Foundation

final class RecipesViewController: UIViewController {

    // MARK: - IBOutlets / IBActions

    @IBOutlet weak private var noRecipeLabel: UILabel!
    @IBOutlet weak private var recipesTableView: UITableView!
    // MARK: - Internal

    // MARK: - Properties - Private

     var recipesDataContainers: [RecipeDataContainer] = [] {
        didSet {
            DispatchQueue.main.async {
                self.recipesTableView.reloadData()
                self.noRecipeLabel.isHidden = !self.recipesDataContainers.isEmpty
            }
        }
    }
    var shouldDisplayFavorites = true
    // MARK: - Methods - Private

    override func viewDidLoad() {
        super.viewDidLoad()
        recipesTableView.dataSource = self
        recipesTableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if shouldDisplayFavorites {
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
    
    // MARK: - Private
    
    // MARK: - Properties - Private
    
    private let fridgeService = FridgeService.shared
    private let coreDataManager = RecipeCoreDataManager.shared
    private let alertManagerController = AlertManagerController.shared
}

// MARK: - Extension

extension RecipesViewController: UITableViewDataSource {
        
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
