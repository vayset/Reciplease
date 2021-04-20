import Foundation

// MARK: - FridgeResponse
struct FridgeResponse: Codable {
    let q: String?
    let from, to: Int?
    let more: Bool?
    let count: Int?
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe?
    let bookmarked, bought: Bool?
}

// MARK: - Recipe
struct Recipe: Codable {
    internal init(uri: String?, label: String?, image: String?, source: String?, url: String?, shareAs: String?, yield: Double?, dietLabels: [String]?, ingredientLines: [String]?, calories: Double?, totalWeight: Double?, totalTime: Int?) {
        self.uri = uri
        self.label = label
        self.image = image
        self.source = source
        self.url = url
        self.shareAs = shareAs
        self.yield = yield
        self.dietLabels = dietLabels
        self.ingredientLines = ingredientLines
        self.calories = calories
        self.totalWeight = totalWeight
        self.totalTime = totalTime
    }
    
    let uri: String?
    let label: String?
    let image: String?
    let source: String?
    let url: String?
    let shareAs: String?
    let yield: Double?
    let dietLabels: [String]?
    let ingredientLines: [String]?
    let calories, totalWeight: Double?
    let totalTime: Int?
}
