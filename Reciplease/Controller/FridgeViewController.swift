import UIKit

class FridgeViewController: UIViewController {
    
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var addIngredientsUIButton: UIButton!
    @IBOutlet weak var clearIngredientsUIButton: UIButton!
    @IBOutlet weak var searchRecipesUIButton: UIButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    private let fridgeService = FridgeService.shared
    private let alertManagerController = AlertManagerController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTextField.delegate = self
        fridgeService.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.delegate = self
        setupUI()
        setupTextViewToolBar()
        
    }
    
    @IBAction func didTapOnAddIngredientsButton() {
        
        guard let ingredient = ingredientsTextField.text else {
            alertManagerController.presentSimpleAlert(from: self, message: "The text field is empty")
            return
        }
        
        switch fridgeService.addIngredient(ingredient) {
        case .failure(let error):
            switch error {
            case .failedToAddIngredientIsEmpty:
                alertManagerController.presentSimpleAlert(from: self, message: "Failed to add ingredient because is empty")
                return
            case .failedToAddIngredientIsTooBig:
                alertManagerController.presentSimpleAlert(from: self, message: "Failed to add ingredient because is toobig")
                return
            }
            
        case .success: ingredientsTextField.text?.removeAll()
        }
    }
    
    @IBAction func didTapOnClearIngredientsButton() {
        fridgeService.ingredients.removeAll()
    }
    @IBAction func didTapOnSearchRecipesButton() {
        activityIndicatorView.startAnimating()
        self.searchRecipesUIButton.setTitle("", for: .normal)
        self.searchRecipesUIButton.isEnabled = false
        
        fridgeService.getRecipes(completion: handleRecipesFetchResponse(fridgeResponse:))
    }
    
    func setupUI() {
        addIngredientsUIButton.layer.cornerRadius = 5
        clearIngredientsUIButton.layer.cornerRadius = 5
        searchRecipesUIButton.layer.cornerRadius = 5
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: ingredientsTextField.frame.height, width: ingredientsTextField.frame.width, height: 1)
        bottomLine.backgroundColor = UIColor(red: 153/255, green: 151/255, blue: 152/255, alpha: 0.6).cgColor
        ingredientsTextField.layer.addSublayer(bottomLine)
        
        ingredientsTextField.attributedPlaceholder = NSAttributedString(string: "Lemon, Cheese, Sausages...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray.withAlphaComponent(0.6)])
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
            
            self.activityIndicatorView.stopAnimating()
            self.searchRecipesUIButton.setTitle("Search for recipes", for: .normal)
            self.searchRecipesUIButton.isEnabled = true
            
            switch fridgeResponse {
            case .failure( _):
                self.alertManagerController.presentSimpleAlert(from: self, message: "Ingredient list is empty")
            case .success(let response):
                
                let recipes = response.hits.map({$0.recipe})
                
                guard !recipes.isEmpty else {
                    self.alertManagerController.presentSimpleAlert(from: self, message: "No recipe matched your ingredients")
                    return
                }
                
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
            destinationViewController.shouldDisplayFavorites = false
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
        cell.textLabel?.text = "- \(fridgeService.ingredients[indexPath.row])"
        return cell
    }
    
}

extension FridgeViewController: UITableViewDelegate {}

extension FridgeViewController: FridgeServiceDelegate {
    func didUpdateIngredients() {
        ingredientsTableView.reloadData()
    }
    
}

extension FridgeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
