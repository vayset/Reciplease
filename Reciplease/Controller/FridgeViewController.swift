import UIKit

class FridgeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsTableView.dataSource = self
        ingredientsTableView.delegate = self
    }
    
    
    @IBOutlet weak var ingredientsTextField: UITextField!
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    let fridgeService = FridegeService()
    
    var ingredients: [String] = [] {
        didSet {
            ingredientsTableView.reloadData()
        }
    }
    

    @IBAction func didTapOnAddIngredientsButton() {
        ingredients.append(ingredientsTextField.text!)
    }
    @IBAction func didTapOnClearIngredientsButton() {
        if ingredients != [] {
            ingredients.remove(at: 0)
        }
    }
    @IBAction func didTapOnSearchRecipesButton() {
    }
    

    func assignRecipeToUiTextField(fridgeResponse: Result<FridgeResponse, NetworkManagerError>) {
        DispatchQueue.main.async {
            switch fridgeResponse {
            case .failure( _):
                print("error")
            case .success(let response):
                self.eachIngredient(ingredinetsTextField: self.ingredientsTextField, response: response)

            }
        }
    }
    

}



extension FridgeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = ingredients[indexPath.row]
        return cell
    }
    
}



extension FridgeViewController: UITableViewDelegate {
 
    
    
    
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//
//        if editingStyle == .delete {
//            ingredients.remove(at: indexPath.row)
//        }
//    }
}
