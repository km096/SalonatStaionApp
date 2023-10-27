//
//  GetServicesModel.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/24/23.
//

import Foundation

// MARK: - GetServicesModel
struct GetServicesModel: Codable {
    let status: Bool?
    let message: String?
    let data: [GetServicesDataModel]?
    let count: Int?
}

// MARK: - GetServicesDataModel
struct GetServicesDataModel: Codable {
    let id: Int?
    let name, description: String?
    let categoryID: Int?
    let categoryName: String?

    enum CodingKeys: String, CodingKey {
        case id, name, description
        case categoryID = "category_id"
        case categoryName = "category_name"
    }
}

