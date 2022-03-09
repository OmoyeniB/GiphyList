import UIKit
import SkeletonView
import XCTest

class MainViewController: UIViewController {
    
    var timer: Timer?
    var mainViewCell = MainViewCell()
    var tableView = UITableView()
    var searchController = UISearchController()
    var gifItem: GifModel?
    var UrlOfTextSearched = ""
    
    override func loadView() {
        super.loadView()
        view = UIView()
        self.view = view
        view.addSubview(tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSerchController()
        gifUILoadedFromServer()
        refreshControl()
    }
    
    func refreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    @objc func didPullToRefresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.tableView.refreshControl?.endRefreshing()
            self.gifUILoadedFromServer()
        })
    }
    
    func configureTableView() {
        tableView.rowHeight = 120
        tableView.separatorColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MainViewCell.self, forCellReuseIdentifier: MainViewCell.identifier)
        
        tableView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
    
    func configureSerchController() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.autocorrectionType = .no
        searchController.searchBar.placeholder = "Type to search ...."
        searchController.automaticallyShowsCancelButton = false
        searchController.delegate = self
    }
    
    func gifUILoadedFromServer() {
        
        let url = URL(string: Constants.getTrendingGifURL)
        GifNetworkCall.shared.fetchGifData(url: url, expecting: GifModel.self) {
            [weak self] result in
            
            switch result {
                case .success(let giphy):
                    
                    DispatchQueue.main.async {
                        self?.gifItem = giphy
                        self?.tableView.reloadData()
                    }
                    
                case .failure(let error):
                    self?.ifNetworkIsOutOfCoverageDisplayErrorMessage()
                    print(error.localizedDescription)
            }
        }
       
    }
}


