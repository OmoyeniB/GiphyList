import UIKit

final class GifNetworkCall {
    static let shared = GifNetworkCall()
    
    private init() {}
    
    enum CustomError: Error {
        case invalidUrl
        case invalidData
    }
    
    public func fetchGifData<T: Codable>(url: URL?, expecting: T.Type, completionHandler: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = url else {
            completionHandler(.failure(CustomError.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                if let error = error {
                    completionHandler(.failure(error)) }
                else {
                    completionHandler(.failure(CustomError.invalidData))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completionHandler(.success(result))
            }
            
            catch {
                completionHandler(.failure(error))
            }
        }
        
        task.resume()
    }
}
