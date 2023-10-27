//
//  NetworkHelper.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/17/23.
//

import Foundation


class NetworkHelper {
    static let shared = NetworkHelper()
    
    func getHeaders() -> [String: String] {
        let token = User.userToken ?? ""
        return [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json",
            "Accept": "application/json",
            "X-Language":"en",
            "Connection": "keep-alive",
             "x-Device": "mobile"
        ]
    }
}
