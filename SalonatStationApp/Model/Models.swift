//
//  Models.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/18/23.
//

import Foundation


// MARK: - GeneralFormatModel
struct GeneralFormatModel: Codable {
    let data,message, errors: String?
    let status: Bool?
}

struct ServiceModel {
    var price: String?
    var numOfPersons: String?
    var offerPrice: String?
    var fromDate: String?
    var toDate: String?
    
    init(price: String? = "", numOfPersons: String? = "", offerPrice: String? = "", fromDate: String? = "", toDate: String? = "") {
        self.price = price
        self.numOfPersons = numOfPersons
        self.offerPrice = offerPrice
        self.fromDate = fromDate
        self.toDate = toDate
    }
}
