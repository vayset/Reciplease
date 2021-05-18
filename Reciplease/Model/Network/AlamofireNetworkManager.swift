import Foundation
import Alamofire

protocol AlamofireNetworkManagerProtocol {
    func fetch<T : Codable>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void)
    func fetchData(url: URL, completion: @escaping (Result<Data, NetworkManagerError>) -> Void)
}

class AlamofireNetworkManager: AlamofireNetworkManagerProtocol {
    init(session: AlamofireSessionProtocol = AlamofireSession()) {
        self.session = session
    }
    
    private let session: AlamofireSessionProtocol
    
    func fetch<T>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void) where T : Decodable, T : Encodable {

        session.getEncodableResponse(url: url) { (dataResponse: DataResponse<T, AFError>) in
            switch dataResponse.result {
            case .failure:
                completion(.failure(.failedToDecodeJSON))
            case .success(let decoddedData):
                completion(.success(decoddedData))
            }
        }
    }
    
    func fetchData(url: URL, completion: @escaping (Result<Data, NetworkManagerError>) -> Void) {
        
        session.getJsonDataResponse(url: url) { dataResponse in
            guard let data = dataResponse.data else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(data))
            return
        }
    }
}
