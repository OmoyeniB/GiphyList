
import UIKit

extension DetailViewController {
    
        func setNavigationItems() {
//            navigationController?.navigationBar.topItem?.title = "back"
            title = "Gif Info Details"
            view.backgroundColor = .white
            navigationController?.navigationBar.tintColor = .black
            let backButtons = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(saveTodo))
            navigationItem.leftBarButtonItem = backButtons
            
           
        }
}


extension MainViewController {
    
    public func hideKeyBoardWhenScreenIsTapped() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(MainViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
