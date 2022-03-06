import UIKit
import SkeletonView

class MainViewController: UIViewController {
    
    var timer: Timer?
    var mainViewCell = MainViewCell()
    var tableView = UITableView()
    var searchController = UISearchController()
    var gifItem: GifModel?
    var searchItem: SearchResult?
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTableView()
        configureTableView()
        configureSerchController()
        gifLoadedOnTheMainThread()
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    @objc func didPullToRefresh() {
        gifLoadedOnTheMainThread()
    }
    
    func configureTableView() {
        tableView.rowHeight = 120
        tableView.separatorColor = .clear
        navigationItem.searchController = searchController
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
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.autocorrectionType = .no
        searchController.searchBar.placeholder = "Type to search ...."
        searchController.automaticallyShowsCancelButton = false
        searchController.delegate = self
    }    
}

extension MainViewController: UISearchControllerDelegate {
   
    func searchBar(_ searchBar: UISearchBar, textDidChange SearchText: String) {
        if let textInputed = searchController.searchBar.text{
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: {
                (_) in
                // in this code block, I'll call my network layer
                let urlString = Constants.getGifSearched(q: self.UrlOfTextSearched)
                let url = URL(string: urlString)
                print("The url serached: \(urlString)")
                GifNetworkCall.shared.fetchGifData(url: url, expecting: SearchResult.self) {
                    [weak self] result in
                    switch result {
                        case .success(let giphy):
                            DispatchQueue.main.async {
                                self?.searchItem = giphy
                                self?.tableView.reloadData()
                            }
                        case .failure(let error):
                            self?.ifNetworkIsOutOfCoverageDisplayErrorMessage()
                            print(error)
                    }
                }
            })
        }
    }
}

extension UIViewController {
    
    public func popUpAlert(title: String, message: String, alertStyle: UIAlertController.Style,
                           actionTitles: [String], actionStyles: [UIAlertAction.Style], actions: [((UIAlertAction) -> Void)]){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        for(index, indexTitle) in actionTitles.enumerated() {
            let action = UIAlertAction(title: indexTitle, style: actionStyles[index], handler: actions[index])
            alertController.addAction(action)
        }
        self.present(alertController, animated: true)
    }
    
    func ifNetworkIsOutOfCoverageDisplayErrorMessage() {
        DispatchQueue.main.async {
            self.popUpAlert(title: "Alert", message: "Oops!.. something went wrong. Please check your connection and try again", alertStyle: .alert,
                       actionTitles: ["OK"], actionStyles: [.default], actions: [ { _ in
                print("User out of network coverage")
            }])
        }
    }
}
