//
//  Models.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/18/23.
//

import Foundation

//MARK: - ServiceModel
struct ServiceModel {
    var price: String?
    var numOfPersons: String?
    var offerPrice: String?
    var fromDate: String?
    var toDate: String?
    
    init(price: String? = nil, numOfPersons: String? = nil, offerPrice: String? = nil, fromDate: String? = nil, toDate: String? = nil) {
        self.price = price
        self.numOfPersons = numOfPersons
        self.offerPrice = offerPrice
        self.fromDate = fromDate
        self.toDate = toDate
    }
    
}

