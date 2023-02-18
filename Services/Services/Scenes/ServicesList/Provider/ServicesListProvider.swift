//
//  ServicesListProvider.swift
//  Services
//
//  Created by Dmitry Maslennikov on 18.02.2023.
//

import Foundation

protocol ProvidesServicesList: AnyObject {
    func fetchServicesList(useCache: Bool, _ completion: @escaping (Result<ServicesResponse, Error>) -> Void)
}

final class ServicesListProvider: ProvidesServicesList {
    
    // MARK: - Private properties
    
    private let networkService: AnyNetworkService<ServicesResponse>
    private let dataStore: DefaultDataStore<ServicesResponse>
    
    // MARK: - Initializer
    
    init(networkService: AnyNetworkService<ServicesResponse>,
         dataStore: DefaultDataStore<ServicesResponse> = .init()) {
        self.networkService = networkService
        self.dataStore = dataStore
    }
    
    // MARK: - ProvidesServicesList
    
    func fetchServicesList(useCache: Bool, _ completion: @escaping (Result<ServicesResponse, Error>) -> Void) {
        if useCache, let cache = dataStore.getValue(), cache.items != [] {
            completion(.success(cache))
        } else {
            networkService.fetchData { [weak self] result in
                if case .success(let data) = result {
                    self?.dataStore.setValue(newValue: data)
                }
                completion(result)
            }
        }
    }
}
