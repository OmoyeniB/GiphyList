import UIKit

final class DetailsViewCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    var viewModel: DetailsViewModel?
    var rootViewController: UIViewController {
        navigationController
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        loadDetailsView()
    }
    
    // MARK: - Methods to be coordinated
    
    func loadDetailsView() {
        let detailsViewController = DetailViewController()
        detailsViewController.viewModel = viewModel
        navigationController.pushViewController(detailsViewController, animated: true)
        
    }
}
