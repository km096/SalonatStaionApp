//
//  SaonService.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/22/23.
//

import Foundation

// MARK: - SalonService
struct SalonService: Codable {
    let status: Bool?
    let message: String?
    let data: [SalonServiceData]?
    let count: Int?
}

// MARK: - SalonServiceData
struct SalonServiceData: Codable {
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

