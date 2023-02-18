//
//  ServicesListInteractor.swift
//  Services
//
//  Created by Dmitry Maslennikov on 18.02.2023.
//

import Foundation

protocol ServicesListBusinessLogic: AnyObject {
    func fetchData()
}

final class ServicesListInteractor: ServicesListBusinessLogic {
    
    // MARK: - Private properties
    
    private let presenter: ServicesListPresentationLogic
    private let provider: ProvidesServicesList
    
    // MARK: - Initializer
    
    init(presenter: ServicesListPresentationLogic, provider: ProvidesServicesList) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: - ServicesListBusinessLogic
    
    func fetchData() {
        provider.fetchServicesList(useCache: false) { [weak presenter] response in
            switch response {
            case .success(let response):
                presenter?.presentFetchedData(.init(servicesList: response))
            case .failure(let error):
                presenter?.presentError(.init(error: error))
            }
        }
    }
}
