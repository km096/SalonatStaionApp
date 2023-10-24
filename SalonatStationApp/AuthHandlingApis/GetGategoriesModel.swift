//
//  GetGategoriesModel.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/24/23.
//

import Foundation

// MARK: - GetCategoriesModel
struct GetCategoriesModel: Codable {
    let status: Bool?
    let message: String?
    let data: [GetCategoriesModelData]?
    let count: Int?
}

// MARK: - GetCategoriesModelData
struct GetCategoriesModelData: Codable {
    let id: Int?
    let name, image: String?
}
