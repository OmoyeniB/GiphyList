import UIKit

final class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewOnLoad()
    }
    
    private func setupViewOnLoad() {
        title = Constants.detailsTitle
    }
}

extension UINavigationController {
    
    func setBackButton() {
        let backButton = UIBarButtonItem()
        backButton.title = nil
        navigationBar.tintColor = .blue
        navigationBar.topItem?.backBarButtonItem = backButton
    }
}

