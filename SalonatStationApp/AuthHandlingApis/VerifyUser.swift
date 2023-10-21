//
//  VerifyUser.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/18/23.
//

import Foundation


// MARK: - SalonUser
struct VerifySalonUser: Codable {
    let status: Bool?
    let message: String?
    let data: DataClass?
    let token: String?
}

// MARK: - DataClass
struct DataClass: Codable {
    let id: Int?
    let name, nameAr, nameEn, email: String?
    let addressEn, addressAr: String?
    let phone: String?
    let address: String?
    let homeLimitPrice: Int?
    let daysWorked, long, lat: String?
    let image, startAt, endAt: String?
    let ibanImage, commercialRegisterImage: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case nameAr = "name_ar"
        case nameEn = "name_en"
        case email
        case addressEn = "address_en"
        case addressAr = "address_ar"
        case phone, address
        case homeLimitPrice = "home_limit_price"
        case daysWorked = "days_worked"
        case long, lat, image
        case startAt = "start_at"
        case endAt = "end_at"
        case ibanImage = "iban_image"
        case commercialRegisterImage = "commercial_register_image"
    }
}
