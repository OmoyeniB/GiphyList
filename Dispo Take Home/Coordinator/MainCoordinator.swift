import UIKit

final class MainCoordinator: Coordinator {
   // APPCoordinator
    let navigationController: UINavigationController
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.navigationController = UINavigationController()
        self.window = window
    }
    
    override func start() {
        navigateToMainView()
    }
    
    func navigateToMainView() {
        let mainViewController = MainViewCoordinator(navigationController: navigationController)
        pushCoordinator(mainViewController)
        window.rootViewController = mainViewController.rootViewController
        window.makeKeyAndVisible()
        
        mainViewController.didFinish = { [weak self] coordinator in
            self?.popCoordinator(coordinator)
        }
    }
    
    func navigateToDetailsView() {
        let detailsViewCoordinator = DetailsViewCoordinator()
        pushCoordinator(detailsViewCoordinator)
        window.rootViewController = detailsViewCoordinator.rootViewController
        window.makeKeyAndVisible()
        
        detailsViewCoordinator.didFinish = { [weak self] coordinator in
            self?.popCoordinator(coordinator)
        }
        
    }
    
}
