import UIKit

class FridgeViewController: UIViewController {
    
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var ingredientsTableView: UITableView!
    @IBOutlet weak var addIngredientsUIButton: UIButton!
    @IBOutlet weak var clearIngredientsUIButton: UIButton!
    @IBOutlet weak var searchRecipesUIButton: UIButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    let fridgeService = FridgeService.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTextField.delegate = self
        fridgeService.delegate = self
        ingredientsTableView.dataSource = self
        ingredientsTableView.delegate = self
        setupUI()
        setupTextViewToolBar()
        
    }
    
    private func presentAlert() {
        let alertController = UIAlertController(title: "Error", message: "blabla", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func didTapOnAddIngredientsButton() {
        
        guard let ingredient = ingredientsTextField.text,
              !ingredient.isEmpty
        else {
            presentAlert()
            return
        }
        
        fridgeService.ingredients.append(ingredientsTextField.text!)
        ingredientsTextField.text?.removeAll()
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
        bottomLine.backgroundColor = UIColor(red: 153/255, green: 151/255, blue: 152/255, alpha: 1.0).cgColor
        ingredientsTextField.layer.addSublayer(bottomLine)
        
        ingredientsTextField.attributedPlaceholder = NSAttributedString(string: "Lemon, Cheese, Sausages...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
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
                self.presentAlert()
            case .success(let response):
                guard let hits = response.hits else {
                    self.presentAlert()
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
