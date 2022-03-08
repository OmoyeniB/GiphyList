import UIKit
import SkeletonView
import XCTest

class MainViewController: UIViewController {
    
    
    var timer: Timer?
    var mainViewCell = MainViewCell()
    var tableView = UITableView()
    var searchController = UISearchController()
    var gifItem: GifModel?
    var searchItem: Giphy?
    var UrlOfTextSearched = ""
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = UIView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTableView()
        configureTableView()
        configureSerchController()
        gifLoadedOnTheMainThread()
        refreshControl()
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
    }
    
    func refreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    @objc func didPullToRefresh() {
        print("refreshing started")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.tableView.refreshControl?.endRefreshing()
//            self.gifLoadedOnTheMainThread()
        })
    }
    
    func configureTableView() {
        tableView.rowHeight = 120
        tableView.separatorColor = .clear
        
    }
    
    func loadTableView() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MainViewCell.self, forCellReuseIdentifier: MainViewCell.identifier)
        
        tableView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
    
    func configureSerchController() {
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
//        navigationItem.searchController = searchController
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.autocorrectionType = .no
        searchController.searchBar.placeholder = "Type to search ...."
        searchController.automaticallyShowsCancelButton = false
        searchController.delegate = self
    }
}

extension MainViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange SearchText: String) {
//
        print(SearchText)
//
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print("The search text is: \(text)")
        let urlString = Constants.getGifSearched(searchText: text)
        
        let url = URL(string: urlString)
        print("The url is: \(url)")
        GifNetworkCall.shared.fetchGifData(url: url, expecting: GifModel.self) { [weak self] result in
            switch result {
                
                case .success(let giphy):
                    print(giphy.data, "This is data")
                    DispatchQueue.main.async {
//                    self?.searchItem = giphy
                        self?.gifItem = giphy
                    self?.tableView.reloadData()
                                               }
                case .failure(let error):
                    
//                    self?.ifNetworkIsOutOfCoverageDisplayErrorMessage()
                    print(error.localizedDescription)
            }
        }
//        if let textInputed = searchController.searchBar.text {
        //            timer?.invalidate()
        //            timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: {
        //                (_) in
        //
        //                let urlString = Constants.getGifSearched(q: self.UrlOfTextSearched)
        //                let url = URL(string: urlString)
        //                print("The url serached: \(urlString)")
        //
        //                GifNetworkCall.shared.fetchGifSearch(url: url ,description: textInputed, expecting: SearchResult.self)
        //                {
        //                    [weak self] result in
        //                    switch result {
        //                        case .success(let giphy):
        //
        //                            DispatchQueue.main.async {
        //                                self?.searchItem = giphy
        //                                self?.tableView.reloadData()
        //                            }
        //
        //                        case .failure(let error):
        //                            self?.ifNetworkIsOutOfCoverageDisplayErrorMessage()
        //                            print(error)
        //                    }
        //                }
        //            })
        //        }
        //
    }
    
}


