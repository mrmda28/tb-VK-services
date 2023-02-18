//
//  ServicesListService.swift
//  Services
//
//  Created by Dmitry Maslennikov on 18.02.2023.
//

import Foundation

final class ServicesListService: NetworkServicing {
    
    typealias Response = ServicesResponse
    
    // MARK: - Private properties
    
    private let urlSession: URLSession
    private let decoder: JSONDecoder
    
    // MARK: - Initializer
    
    init(urlSession: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.urlSession = urlSession
        self.decoder = decoder
    }
    
    // MARK: - NetworkServicing
    
    func fetchData(completion: @escaping (Result<Response, Error>) -> Void) {
        let uri = "https://mobile-olympiad-trajectory.hb.bizmrg.com/semi-final-data.json"
        
        guard let url = URL(string: uri) else {
            completion(.failure(NetworkError.badURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        let dataTask = urlSession.dataTask(with: request) { [weak self] data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(NetworkError.dataFailed))
                    return
                }
                guard let response = try? self?.decoder.decode(Response.self, from: data) else {
                    completion(.failure(NetworkError.decodeFailed))
                    return
                }
                
                completion(.success(response))
            }
        }
        
        dataTask.resume()
    }
}
