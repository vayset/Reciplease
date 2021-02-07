//
//  RecipesViewController.swift
//  Reciplease
//
//  Created by Saddam Satouyev on 07/02/2021.
//
import UIKit
import Foundation

class RecipesViewController: UIViewController {
    
    var recipes: [Recipe]?
    
    @IBOutlet weak var recipesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipesTableView.dataSource = self
        recipesTableView.delegate = self
    }
    
    
}

extension RecipesViewController: UITableViewDataSource  {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell") as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        
        guard let recipe = recipes?[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.configure(recipe: recipe)
        
        return cell
    }
    
}

extension RecipesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
