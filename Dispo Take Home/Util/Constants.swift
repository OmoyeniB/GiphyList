import Foundation

enum Constants {}

extension Constants {
    // Get an API key from https://developers.giphy.com/dashboard/
    static let baseURL = "https://api.giphy.com/v1/gifs/"
    static let giphyApiKey = "lVKYZAM1Ni7MvPA613oBP1qwc7ihzgFU"
    static let getTrendingGifURL = "\(baseURL)trending?api_key=\(giphyApiKey)&limit=25&trending"
    static func getGifByIDURL(id: String) -> String {"\(baseURL)\(id)?api_key=\(giphyApiKey)"}
}
