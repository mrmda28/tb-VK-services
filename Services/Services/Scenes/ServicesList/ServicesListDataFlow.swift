//
//  ServicesListDataFlow.swift
//  Services
//
//  Created by Dmitry Maslennikov on 18.02.2023.
//

import UIKit

enum ServicesListDataFlow {
    enum FetchData {
        struct Response {
            let servicesList: ServicesResponse
        }
        struct ViewModel {
            let servicesList: [ServiceDetail]
        }
    }
    
    enum Error {
        struct Response {
            let error: Swift.Error
        }
        struct ViewModel {
            let title: String
            let message: String
        }
    }
}
