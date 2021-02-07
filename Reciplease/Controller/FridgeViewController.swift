import UIKit

class FridgeViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fridgeService.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.delegate = self
        
    }
    
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var ingredientsTableView: UITableView!

    let fridgeService = FridgeService()
    
    @IBAction func didTapOnAddIngredientsButton() {
        fridgeService.ingredients.append(ingredientsTextField.text!)
        ingredientsTextField.text?.removeAll()
    }
    @IBAction func didTapOnClearIngredientsButton() {
        fridgeService.ingredients.removeAll()
    }
    @IBAction func didTapOnSearchRecipesButton() {
        fridgeService.getRecipes(completion: handleRecipesFetchResponse(fridgeResponse:))
    }
    
    private func handleRecipesFetchResponse(fridgeResponse: Result<FridgeResponse, NetworkManagerError>) {
        
        DispatchQueue.main.async {
            
            switch fridgeResponse {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                let recipes = response.hits!.map({$0.recipe})
                
                self.performSegue(withIdentifier: "goToRecipesSegue", sender: recipes)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let destinationViewController = segue.destination as? RecipesViewController {
            destinationViewController.recipes = sender as? [Recipe]
        }
        
    }
    
}

extension FridgeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fridgeService.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = fridgeService.ingredients[indexPath.row]
        return cell
    }
    
}

extension FridgeViewController: UITableViewDelegate {}

extension FridgeViewController: FridgeServiceDelegate {
    func didUpdateIngredients() {
        ingredientsTableView.reloadData()
    }
    
    
}
