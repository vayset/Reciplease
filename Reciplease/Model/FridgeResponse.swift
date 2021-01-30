import Foundation

// MARK: - FridgeService
struct FridgeResponse: Codable {
    let q: String?
    let from, to: Int?
    let more: Bool?
    let count: Int?
}

// MARK: - Recipe
struct Recipe: Codable {
    let uri: String?
    let label: String?
    let image: String?
    let source: String?
    let url: String?
    let shareAs: String?
    let yield: Int?
    let dietLabels: [String]?
    let ingredientLines: [String]?
    let calories, totalWeight: Double?
    let totalTime: Int?
}
