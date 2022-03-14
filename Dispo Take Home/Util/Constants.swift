import Foundation

enum Constants {}

extension Constants {
    
    static let baseURL = "https://api.giphy.com/v1/gifs/"
    static let giphyApiKey = "lVKYZAM1Ni7MvPA613oBP1qwc7ihzgFU"
    static let getTrendingGifURL = "\(baseURL)trending?api_key=\(giphyApiKey)"
    static func getGifByIDURL(id: String) -> String { "\(baseURL)\(id)?api_key=\(giphyApiKey)" }
    static func getGifSearched(searchText:String) -> String { "\(baseURL)search?q=\(searchText)&api_key=\(giphyApiKey)" }
    
    static let popUpActionTitles = "OK"
    static let popUpTitle = "Alert"
    static let detailsTitle = "Gif Info Details"
    static let networkOutOfCoverage = "Oops!.. something went wrong. Please check your connection and try again"
    static let noSourceFound = "No source found"
    static let gifTitleRatingsLabel = "Rating:"
    static let gifSourceLabel = "Source:"
    static let titleLableText = "Title:"
    static let searchBarPlaceHolder = "Type to search ...."
    
}
