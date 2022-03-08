import Foundation

enum Constants {}

extension Constants {
    // Get an API key from https://developers.giphy.com/dashboard/
    static let baseURL = "https://api.giphy.com/v1/gifs/"
    static let giphyApiKey = "lVKYZAM1Ni7MvPA613oBP1qwc7ihzgFU"
    static let searchRequiredParameter = "search?q="
    static let getTrendingGifURL = "\(baseURL)trending?api_key=\(giphyApiKey)"
    static func getGifByIDURL(id: String) -> String {"\(baseURL)\(id)?api_key=\(giphyApiKey)"}
    static func getGifSearched(searchText:String) -> String {"\(baseURL)search?q=\(searchText)&api_key=\(giphyApiKey)"}
}

//https://api.giphy.com/v1/gifs/search?q=grace&api_key=lVKYZAM1Ni7MvPA613oBP1qwc7ihzgFU
//(q: String) -> String {"\(baseURL)\(searchRequiredParameter)\(q)&api_key=\(giphyApiKey)"}
