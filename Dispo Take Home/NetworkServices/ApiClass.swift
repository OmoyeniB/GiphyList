import UIKit
import Kingfisher
final class GifNetworkCall {
    static let shared = GifNetworkCall()
    
    private init(){
        
    }
    public func fetchGifData(completionHandler: @escaping ([Giphy]) -> Void) {
        
        let urlString = "https://api.giphy.com/v1/gifs/trending?api_key=lVKYZAM1Ni7MvPA613oBP1qwc7ihzgFU&limit=25&rating=g"
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                return
            }
            guard let gifData = try? JSONDecoder().decode(GifModel.self, from: data) else {
                return
            }
            completionHandler(gifData.data)
        }
        task.resume()
    }
}


extension UIImageView {
    func setImage(imageUrl: String, placeholder: String) {
        self.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(named: placeholder))
        
//        let url = URL(string: "https://example.com/image.png")
//        imageView.kf.setImage(with: url)
    }
    
}
