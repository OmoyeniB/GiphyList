////
////  RefreshData.swift
////  Dispo Take Home
////
////  Created by Decagon on 07/03/2022.
////
//
//import UIKit
//
////import Foundation
////import UIKit
////
//extension UIScrollView {
//    static var refreshAction: (() -> Void)?
//    func createRefreshControl() -> UIRefreshControl {
//        
//        let refreshControl = UIRefreshControl()
//        self.refreshControl = refreshControl
//        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
//        return refreshControl
//    }
//
//    
//    @objc func didPullToRefresh() {
//        
//        print("refreshing started")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
//            self.refreshControl?.beginRefreshing()
//            self.refreshAction?()
//            
//        })
//    }
//    
//    func endRefreshing() {
//        self.refreshControl?.endRefreshing()
//    }
//}
