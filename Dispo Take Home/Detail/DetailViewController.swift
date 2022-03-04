import UIKit

class DetailViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    lazy var gifImage: UIImageView = {
        var gifImage = UIImageView()
        gifImage.backgroundColor = .red
        return gifImage
    }()
    
    lazy var gifTitle: UILabel = {
        var gifTitle = UILabel()
        gifTitle.numberOfLines = 2
        gifTitle.textAlignment = .center
        gifTitle.text = "Title: Free money cartoon GIF by Spongebob SquarePants"
        return gifTitle
    }()
    
    lazy var sourceLabel: UILabel = {
        var sourceLabel = UILabel()
        sourceLabel.text = "Source: gifhell.com"
        return sourceLabel
    }()
    
    lazy var ratingsLabel: UILabel = {
        var ratingsLabel = UILabel()
        ratingsLabel.text = "Rating: g"
        return ratingsLabel
    }()
    
    @objc func saveTodo() {
        let newVC = MainViewController()
        navigationController?.pushViewController(newVC, animated: true)
    }
    
}

















//func gifLoadedOnTheMainThread() {
//    let dataFetchedFromApi = { (fetchGifData: [Giphy]) in
//        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
//            self.giphy = fetchGifData
//            self.tableView.reloadData()
//        })
//    }
//    GifNetworkCall.shared.fetchGifData(completionHandler: dataFetchedFromApi)
//}
//
//}


//func gifLoadedOnTheMainThread() {
//    let dataFetchedFromApi = { (fetchGifData: [Giphy]) in
//        DispatchQueue.main.async {
//            self.giphy = fetchGifData
//            self.tableView.reloadData()
//        }
//    }
//    GifNetworkCall.shared.fetchGifData(completionHandler: dataFetchedFromApi)
//}
//
//}
