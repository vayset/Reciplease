import Foundation


protocol NetworkManagerProtocol {
    func fetch<T : Codable>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    let session: URLSession
    
    func fetch<T : Codable>(url: URL, completion: @escaping (Result<T, NetworkManagerError>) -> Void)  {
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                completion(.failure(.unknownError))
                return
            }
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else {
                completion(.failure(.invalidHttpStatusCode))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoddedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoddedData))
                return
            } catch {
                print(error)
                completion(.failure(.failedToDecodeJSON))
                return
            }
            
   
        
        }
        
        task.resume()
    }
    
}
