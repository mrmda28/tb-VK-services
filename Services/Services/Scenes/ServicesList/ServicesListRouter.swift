//
//  ServicesListRouter.swift
//  Services
//
//  Created by Dmitry Maslennikov on 18.02.2023.
//

import UIKit

protocol ServicesListRouting {
    func routeToAlert(title: String, message: String)
    func routeToServiceDetail()
}

final class ServicesListRouter: ServicesListRouting {
    
    weak var viewController: UIViewController?
    
    func routeToAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        viewController?.present(alert, animated: true)
    }
    
    func routeToServiceDetail() {
        
    }
}
