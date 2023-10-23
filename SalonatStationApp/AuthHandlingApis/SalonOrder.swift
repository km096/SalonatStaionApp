//
//  SalonOrder.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/21/23.
//

import UIKit

// MARK: - SalonOrder
struct SalonOrder: Codable {
    let status: Bool?
    let message: String?
    let data: [SalonOrderData]?
    let count: Int?
}

// MARK: - SalonOrderData
struct SalonOrderData: Codable {
    let id: Int?
    let date, time: String?
    let personNumber: Int?
    let status: String?
    let totalPrice, rate: Int?
    let userName, userEmail, userPhone, payment: String?
    let rateComment, complaintComment: String?
    let address: String?
    let services: [Service]?

    enum CodingKeys: String, CodingKey {
        case id, date, time
        case personNumber = "person_number"
        case status
        case totalPrice = "total_price"
        case rate
        case userName = "user_name"
        case userEmail = "user_email"
        case userPhone = "user_phone"
        case payment
        case rateComment = "rate_comment"
        case complaintComment = "complaint_comment"
        case address, services
    }
}

// MARK: - Service
struct Service: Codable {
    let id: Int?
    let name, description: String?
    let categoryID: Int?
    let categoryName: String?
    let price, addition, typeID: Int?
    let typeName: String?

    enum CodingKeys: String, CodingKey {
        case id, name, description
        case categoryID = "category_id"
        case categoryName = "category_name"
        case price, addition
        case typeID = "type_id"
        case typeName = "type_name"
    }
}
