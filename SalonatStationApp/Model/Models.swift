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
