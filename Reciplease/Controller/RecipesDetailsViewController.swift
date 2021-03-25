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
    @IBOutlet weak var getDirectionsOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableView.delegate = self
        ingredientsTableView.dataSource = self
        setupUI()
    }
    
    @IBAction func getDirectionsUIButton(_ sender: Any) {
        
    }
    
    func createGradientsEffect() {

    }
    
    private func setupUI() {
        recipeTitleLabel.text = recipeDataContainer.first?.recipe.label
        if let photoData = recipeDataContainer.first?.photo {
            print(photoData)
            recipeImageView.image = UIImage(data: photoData)
        }
        getDirectionsOutlet.layer.cornerRadius = 5
        let colorBrown = UIColor(red: 57/255, green: 51/255, blue: 50/255, alpha: 1.0)
        let gradient = CAGradientLayer()
        gradient.frame = recipeImageView.bounds
        gradient.colors = [UIColor.clear.cgColor, colorBrown.cgColor]
        gradient.frame = recipeImageView.bounds
        gradient.locations = [0.2, 1.1]
        recipeImageView.layer.addSublayer(gradient)
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
        let cellText = "- \(recipeDataContainer.first?.recipe.ingredientLines![indexPath.row] ?? "Error")"
        

        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "Chalkduster", size: 15.0)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = cellText
        return cell
    }

    
}

extension RecipesDetailsViewController: UITableViewDelegate {
    
}
