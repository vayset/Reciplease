import Foundation

// MARK: - FridgeResponse
struct FridgeResponse: Codable {
    let q: String?
    let from, to: Int?
    let more: Bool?
    let count: Int?
    let hits: [Hit]?
}

// MARK: - Hit
struct Hit: Codable {
    let recipe: Recipe?
    let bookmarked, bought: Bool?
}

// MARK: - Recipe
struct Recipe: Codable {
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
