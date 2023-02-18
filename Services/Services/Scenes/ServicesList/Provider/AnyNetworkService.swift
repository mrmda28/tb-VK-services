//
//  AnyNetworkService.swift
//  Services
//
//  Created by Dmitry Maslennikov on 18.02.2023.
//

import Foundation

protocol NetworkServicing: AnyObject {
    associatedtype Response = Decodable
    func fetchData(completion: @escaping (Result<Response, Error>) -> Void)
}

final class AnyNetworkService<T: Decodable>: NetworkServicing {
    
    typealias Response = T
    
    // MARK: - Private properties
    
    private let fetchListMethod: (@escaping (Result<Response, Error>) -> Void) -> Void
    
    // MARK: - Initializer
    
    init<C: NetworkServicing>(_ concrete: C) where C.Response == Response {
        fetchListMethod = concrete.fetchData
    }
    
    // MARK: - NetworkServicing
    
    func fetchData(completion: @escaping (Result<Response, Error>) -> Void) {
        fetchListMethod(completion)
    }
}
