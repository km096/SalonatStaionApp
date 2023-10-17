//
//  User.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/17/23.
//

import UIKit


// MARK: - User
struct User: Codable {
    let id: Int?
    let name, email, phone, image: String?
    let isActive, isCompleted, points, wallet: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, email, phone, image
        case isActive
        case isCompleted
        case points, wallet
    }
    
    func storeUser() {
        let user = Coder().encode(fromCodable: self)
        UserDefaults.standard.set(user, forKey: Constants.UserKey)
    }
    
    static func getUser() -> User? {
        guard let userData = UserDefaults.standard.data(forKey: Constants.UserKey),
                let user = Coder().decode(toType: User.self, jsonData: userData) else {
            return nil
        }
        
        return user
    }
    
    static var userId: Int? {
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.UserIdKey)
        }
        get {
            let userID = UserDefaults.standard.integer(forKey: Constants.UserIdKey)
            if userID != 0 {
                return userID
            }
            return nil
        }
    }
    
    static var userToken: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.AccessTokenKey)
        }
        get {
            return UserDefaults.standard.string(forKey: Constants.AccessTokenKey)
        }
    }
}
