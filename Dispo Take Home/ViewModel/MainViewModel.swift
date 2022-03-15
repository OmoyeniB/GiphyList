import Foundation

final class MainViewModel {
    
    static func fetchDataFromServer(completion: @escaping ((Result<GifModel, Error>) -> Void)) {
        let url = URL(string: Constants.getTrendingGifURL)
        GifNetworkCall.shared.fetchGifData(url: url, expecting: GifModel.self) {
            result in
            switch result {
                case .success(let giphy):
                    completion(.success(giphy))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    static func fetchDataForSearchBar(text: String, completion: @escaping ((Result<GifModel, Error>)-> Void)) {
        
        let urlString = Constants.getGifSearched(searchText: text)
        let url = URL(string: urlString)
        
        GifNetworkCall.shared.fetchGifData(url: url, expecting: GifModel.self) {
            result in
            switch result {
                case .success(let giphy):
                    completion(.success(giphy))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
        
    }
}
