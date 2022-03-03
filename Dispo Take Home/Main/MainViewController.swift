import UIKit
import SkeletonView

class MainViewController: UIViewController {
    
    var mainViewCell = MainViewCell()
    var tableView = UITableView()
    var searchController = UISearchController()
    var giphy = [Giphy]()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = .clear
        loadTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        configureTableView()
        configureSerchController()
        gifLoadedOnTheMainThread()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.mainViewCell.gifTitle.showAnimatedGradientSkeleton()
        self.mainViewCell.gifTitle.isSkeletonable = true
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
//            self.mainViewCell.gifTitle.hideSkeleton()
//        })
//        
//      
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
//            self.mainViewCell.gifImage.hideSkeleton()
//        })

    }
    
    func configureTableView() {
        tableView.rowHeight = 120
        tableView.keyboardDismissMode = .onDrag
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
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.autocorrectionType = .no
        searchController.searchBar.placeholder = "Type to search ...."
    }    
}
