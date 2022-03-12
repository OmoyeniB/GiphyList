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
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        getGifByID()
        refreshControl()
        showSkeletonView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
    
    func refreshControl() {
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    @objc func didPullToRefresh() {
        print("refreshing started")
        DispatchQueue.main.async {
            self.scrollView.refreshControl?.beginRefreshing()
        }
        didStopRefreshing()
    }
    
    func didStopRefreshing() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.scrollView.refreshControl?.endRefreshing()
            self.getGifByID()
        })
    }
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.autoresizingMask = .flexibleHeight
        view.bounces = true
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var gifImage: UIImageView = {
        var gifImage = UIImageView()
        gifImage.clipsToBounds = true
        gifImage.contentMode = .scaleAspectFill
        gifImage.isSkeletonable = true
        
        gifImage.showAnimatedGradientSkeleton()
        
        return gifImage
    }()
    
    lazy var gifTitleLabel: UILabel = {
        var gifTitleLabel = UILabel()
        gifTitleLabel.text = "Title:"
        return gifTitleLabel
    }()
    
    lazy var gifTitle: UILabel = {
        var gifTitle = UILabel()
        gifTitle.numberOfLines = 2
        gifTitle.textAlignment = .center
        gifTitle.isSkeletonable = true
        return gifTitle
    }()
    
    lazy var gifSourceLabel:  UILabel = {
        var gifTitleLabel = UILabel()
        gifTitleLabel.text = "Source:"
        return gifTitleLabel
    }()
    
    lazy var sourceLabel: UILabel = {
        var sourceLabel = UILabel()
        sourceLabel.isSkeletonable = true
        return sourceLabel
    }()
    
    lazy var sourceStackView: UIStackView = {
        var sourceStackView = UIStackView()
        sourceStackView.axis = .horizontal
        sourceStackView.spacing = 10
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
        return ratingsLabel
    }()
    
    func showSkeletonView() {
        ratingsLabel.showAnimatedGradientSkeleton()
        sourceLabel.showAnimatedGradientSkeleton()
        gifTitle.showAnimatedGradientSkeleton()
        gifImage.showAnimatedGradientSkeleton()
        gifImage.showAnimatedGradientSkeleton()
    }
    
    func hideSkeletonView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.gifImage.hideSkeleton()
            self.ratingsLabel.hideSkeleton()
            self.sourceLabel.hideSkeleton()
            self.gifTitle.hideSkeleton()
        })
    }
    
    private func getGifByID() {
        let urlString = Constants.getGifByIDURL(id: giphID)
        guard let url = URL(string: urlString) else { return }
        
        GifNetworkCall.shared.fetchGifData(url: url, expecting: GifItem.self) { [weak self] result  in
            switch result {
                case .success(let item):
                    
                    DispatchQueue.main.async {
                        
                        self?.hideSkeletonView()
                        guard let urlString = item.data?.images?.original?.url else { return }
                        guard let url = URL(string: urlString) else { return }
                        self?.gifImage.kf.setImage(with: url)
                        
                        self?.gifTitle.text = item.data?.title
                        self?.ratingsLabel.text = item.data?.rating
                        
                        guard let sourceText = item.data?.source_tld, sourceText.count >= 2 else {
                            self?.sourceLabel.text = "No source found"
                            return
                        }
                        self?.sourceLabel.text = sourceText
                    }
                    
                case .failure(let error):
                    self?.hideSkeletonView()
                    self?.ifNetworkIsOutOfCoverageDisplayErrorMessage()
                    print(error.localizedDescription)
            }
        }
    }
    
}
