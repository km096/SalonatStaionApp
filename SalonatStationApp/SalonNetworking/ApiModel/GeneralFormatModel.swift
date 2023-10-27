//
//  GeneralFormatModel.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/28/23.
//

import Foundation

// MARK: - GeneralFormatModel
struct GeneralFormatModel: Codable {
    let data,message, errors: String?
    let status: Bool?
}
