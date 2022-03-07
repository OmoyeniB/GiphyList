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
        
        gifImage.isSkeletonable = true
        gifImage.showAnimatedGradientSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            gifImage.hideSkeleton()
        })
        return gifImage
    }()
    
    lazy var gifTitleLabel:  UILabel = {
       var gifTitleLabel = UILabel()
        gifTitleLabel.text = "Title:"
        return gifTitleLabel
    }()
    
    lazy var gifTitle: UILabel = {
        var gifTitle = UILabel()
        gifTitle.numberOfLines = 2
        gifTitle.textAlignment = .center
        
        gifTitle.isSkeletonable = true
        gifTitle.showAnimatedGradientSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
            gifTitle.hideSkeleton()
        })
        return gifTitle
    }()
    
    lazy var titleStackView: UIStackView = {
       var titleStackView = UIStackView()
        titleStackView.axis = .horizontal
        titleStackView.addArrangedSubview(gifTitleLabel)
        titleStackView.addArrangedSubview(gifTitle)
        return titleStackView
    }()
    
    lazy var gifSourceLabel:  UILabel = {
       var gifTitleLabel = UILabel()
        gifTitleLabel.text = "Source:"
        return gifTitleLabel
    }()
    
    lazy var sourceLabel: UILabel = {
        var sourceLabel = UILabel()
        
        sourceLabel.isSkeletonable = true
        sourceLabel.showAnimatedGradientSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
            sourceLabel.hideSkeleton()
        })
        return sourceLabel
    }()
    
    lazy var sourceStackView: UIStackView = {
       var sourceStackView = UIStackView()
        sourceStackView.axis = .horizontal
      sourceStackView.addArrangedSubview(gifSourceLabel)
        sourceStackView.addArrangedSubview(sourceLabel)
        return sourceStackView
    }()
    
    
    lazy var gifRatingsLabel:  UILabel = {
       var gifTitleLabel = UILabel()
        gifTitleLabel.text = "Rating:"
        return gifTitleLabel
    }()
    
    lazy var ratingsLabel: UILabel = {
        var ratingsLabel = UILabel()
        
        ratingsLabel.isSkeletonable = true
        ratingsLabel.showAnimatedGradientSkeleton()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
            ratingsLabel.hideSkeleton()
        })
        return ratingsLabel
    }()
    
    lazy var ratingStackView: UIStackView = {
       var ratingStackView = UIStackView()
        ratingStackView.axis = .horizontal
//        ratingStackView.distribution = .equalCentering
        ratingStackView.spacing = 12
        ratingStackView.addArrangedSubview(gifRatingsLabel)
        ratingStackView.addArrangedSubview(ratingsLabel)
        return ratingStackView
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
                            self?.gifTitle.text = "This is a default title"
                        }
                        else{
                            self?.gifTitle.text = item.data?.title
                        }
                        self?.sourceLabel.text = item.data?.source_tld
                        self?.ratingsLabel.text = item.data?.rating
                    }
                case .failure(let error):
                    self?.ifNetworkIsOutOfCoverageDisplayErrorMessage()
                    print(error.localizedDescription)
            }
        }
    }
    
}
