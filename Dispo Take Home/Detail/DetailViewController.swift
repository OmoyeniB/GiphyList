import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    var giphID = ""
    var gifItem: GifItem?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = UIView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        view.backgroundColor = .systemBackground
        getGifByID()
    }
    
    lazy var gifImage: UIImageView = {
        var gifImage = UIImageView()
        gifImage.clipsToBounds = true
        gifImage.contentMode = .scaleAspectFill
        return gifImage
    }()
    
    lazy var gifTitle: UILabel = {
        var gifTitle = UILabel()
        gifTitle.numberOfLines = 2
        gifTitle.textAlignment = .center
        return gifTitle
    }()
    
    lazy var sourceLabel: UILabel = {
        var sourceLabel = UILabel()
        return sourceLabel
    }()
    
    lazy var ratingsLabel: UILabel = {
        var ratingsLabel = UILabel()
        return ratingsLabel
    }()
    
    func getGifByID() {
        let urlString = Constants.getGifByIDURL(id: giphID)
        print("The URL is: ", urlString)
        let url = URL(string: urlString)!
        
        GifNetworkCall.shared.fetchGifData(url: url, expecting: GifItem.self) { [weak self] result  in
            switch result {
                case .success(let item):
                    DispatchQueue.main.async {
                        guard let urlString = item.data?.images?.original?.url else { return }
                        guard let url = URL(string: urlString) else { return }
                        self?.gifImage.kf.setImage(with: url)
                        
                        if item.data?.title == nil {
                            self?.gifTitle.text = "This is a default"
                        }
                        else{
                            self?.gifTitle.text = item.data?.title
                        }
                        self?.sourceLabel.text = item.data?.source_tld
                        self?.ratingsLabel.text = item.data?.rating
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
}
