import UIKit
import SkeletonView
import XCTest

class MainViewController: UIViewController {
    
    let tableView = UITableView()
    let searchController = UISearchController()
    var viewModel: MainViewModel?
    var didSelectRow: ((String) -> Void)?
    var timer: Timer?
    var gifItem: GifModel?
    
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
    
    private func refreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    @objc func didPullToRefresh() {
        
        DispatchQueue.main.async{
            self.tableView.refreshControl?.beginRefreshing()
            self.gifUILoadedFromServer()
            self.refreshEnd()
        }
    }
    
    func refreshEnd() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.tableView.refreshControl?.endRefreshing()
        })
    }
    
    private func configureTableView() {
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
        searchController.searchBar.placeholder = Constants.searchBarPlaceHolder
        searchController.automaticallyShowsCancelButton = false
        searchController.delegate = self
    }
    
    func gifUILoadedFromServer() {
        
        MainViewModel.fetchDataFromServer {result in
            switch result {
                case .success(let giphy):
                    DispatchQueue.main.async {
                        self.gifItem = giphy
                        self.tableView.reloadData()
                    }
                    
                case .failure(_):
                    self.displayError(error: Constants.networkOutOfCoverage)
            }
        }
        
    }
}
