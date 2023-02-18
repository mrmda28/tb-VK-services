//
//  ServiceDetail.swift
//  Services
//
//  Created by Dmitry Maslennikov on 18.02.2023.
//

struct ServiceDetail: Equatable, Decodable {
    let name: String
    let description: String
    let iconUrl: String
    let serviceUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case iconUrl = "icon_url"
        case serviceUrl = "service_url"
    }
}
