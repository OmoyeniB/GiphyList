import UIKit
import SkeletonView

class MainViewController: UIViewController {

    var mainViewCell = MainViewCell()
    var tableView = UITableView()
    var searchController = UISearchController()
    var gifItem: GifModel?
    
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
    }    
}
