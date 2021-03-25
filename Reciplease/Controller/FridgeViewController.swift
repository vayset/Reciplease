import UIKit

class FridgeViewController: UIViewController {
    
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var addIngredientsUIButton: UIButton!
    @IBOutlet weak var clearIngredientsUIButton: UIButton!
    @IBOutlet weak var searchRecipesUIButton: UIButton!
    
    let fridgeService = FridgeService.shared

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fridgeService.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.delegate = self
        setupUI()
        setupTextViewToolBar()
    }
    
    
    @IBAction func didTapOnAddIngredientsButton() {
        fridgeService.ingredients.append("- \(ingredientsTextField.text!)")
        ingredientsTextField.text?.removeAll()
    }
    @IBAction func didTapOnClearIngredientsButton() {
        fridgeService.ingredients.removeAll()
    }
    @IBAction func didTapOnSearchRecipesButton() {
        fridgeService.getRecipes(completion: handleRecipesFetchResponse(fridgeResponse:))
    }
    
    func setupUI() {
        addIngredientsUIButton.layer.cornerRadius = 5
        clearIngredientsUIButton.layer.cornerRadius = 5
        searchRecipesUIButton.layer.cornerRadius = 5
    }
    
    private func setupTextViewToolBar() {
        let toolBar = UIToolbar(
            frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35)
        )
        
        toolBar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(closeKeyboard))
        ]

        ingredientsTextField.inputAccessoryView = toolBar
    }
    
    @objc private func closeKeyboard() {
        ingredientsTextField.resignFirstResponder()
    }
    
    private func handleRecipesFetchResponse(fridgeResponse: Result<FridgeResponse, NetworkManagerError>) {
        
        DispatchQueue.main.async {
            
            switch fridgeResponse {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                guard let hits = response.hits else {
                    // presentAlert
                    return
                }
                let recipes = hits.map({$0.recipe})
                self.performSegue(withIdentifier: "goToRecipesSegue", sender: recipes)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if
            let destinationViewController = segue.destination as? RecipesViewController,
            let recipes = sender as? [Recipe]
        {
            destinationViewController.recipesDataContainers = recipes.map { RecipeDataContainer(recipe: $0) }
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
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "Chalkduster", size: 24)
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
