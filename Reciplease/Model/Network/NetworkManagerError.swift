import Foundation

enum NetworkManagerError: LocalizedError {
    case noData
    case failedToDecodeJSON
    case unknownError
    case invalidHttpStatusCode
    
    var errorDescription: String? {
        switch self {
        case .failedToDecodeJSON: return "Failed to decode json"
        case .invalidHttpStatusCode: return "invalid httpt status code"
        case .noData: return "No data"
        case .unknownError: return "Unknown error occured"
        }
    }
}
