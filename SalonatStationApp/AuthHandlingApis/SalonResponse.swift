//
//  SalonResponse.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/17/23.
//

import Foundation

// MARK: - SalonUser
struct SalonUser: Codable {
    let token: String?
    let data: SalonUserData?
    let message: String?
    let status: Bool?
}

// MARK: - SalonUserData
struct SalonUserData: Codable {
    let id: Int?
    let name, email, phone, image: String?
    let isActive, isCompleted, points, wallet: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, email, phone, image
        case isActive = "is_active"
        case isCompleted = "is_completed"
        case points, wallet
    }
}
