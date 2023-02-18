//
//  ServicesListPresenter.swift
//  Services
//
//  Created by Dmitry Maslennikov on 18.02.2023.
//

import Foundation

protocol ServicesListPresentationLogic: AnyObject {
    func presentFetchedData(_ response: ServicesListDataFlow.FetchData.Response)
    func presentError(_ response: ServicesListDataFlow.Error.Response)
}

final class ServicesListPresenter: ServicesListPresentationLogic {
    
    // MARK: - Internal properties
    
    weak var viewController: ServicesListDisplayLogic?
    
    // MARK: - ServicesListPresentationLogic
    
    func presentFetchedData(_ response: ServicesListDataFlow.FetchData.Response) {
        viewController?.displayFetchedData(.init(servicesList: response.servicesList.items))
    }
    
    func presentError(_ response: ServicesListDataFlow.Error.Response) {
        viewController?.displayError(.init(title: "Error", message: response.error.localizedDescription))
    }
}
