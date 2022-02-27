import Foundation
import UIKit
import Kingfisher
final class GifNetworkCall {
    static let shared = GifNetworkCall()
    
    private init(){
        
    }
    public func fetchGifData(completionHandler: @escaping ([Giphy]) -> Void) {
        let urlString = "https://api.giphy.com/v1/gifs/trending?api_key=lVKYZAM1Ni7MvPA613oBP1qwc7ihzgFU&limit=25&rating=g"
        let url = URL(string: urlString)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                print("data was nil")
                return
            }
            guard let gifData = try? JSONDecoder().decode(GifModel.self, from: data) else {
                print("couldn't decode data")
                return
            }
            completionHandler(gifData.data)
//            print(gifData.data, "Yaay data was printed")
        }
        task.resume()
    }
}


extension UIImageView {
    func setImage(imageUrl: String) {
        self.kf.setImage(with: URL(string: imageUrl))
    }
}
