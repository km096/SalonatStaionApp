//
//  Constants.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/16/23.
//

import UIKit


struct Constants {
    
    static let storyboardName = "Main"
    static let dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    struct Identifiers {
        static let loginVC = "loginID"
        static let verifacationCodeVC = "VerifacationCodeID"
        static let tabBarController = "TabBarControllerID"
        static let salonServiceVC = "SalonServiceID"
        static let addServiceVC = "addServiceID"        
    }
    
    struct Colors {
        static let tabBar = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        static let tabBarSelected = #colorLiteral(red: 0.9552590251, green: 0.4643781185, blue: 0.4304232001, alpha: 1)
        static let tabBarUnselected = #colorLiteral(red: 0.9552590251, green: 0.4643781185, blue: 0.4304232001, alpha: 0.5004046105)
        static let greyFont = #colorLiteral(red: 0.5, green: 0.5, blue: 0.5000000596, alpha: 1)
        static let pinkColor = #colorLiteral(red: 0.9552590251, green: 0.4643781185, blue: 0.4304232001, alpha: 1)
    }
    
   
    
    static let baseURL = "https://beauty-station.appssquare.com/api"
    
    static let UserKey = "UserKey"
    static let UserIdKey = "UserIdKey"
    static let salonIdKey = "SalonIdKey"
    static let salonNameArKey = "SalonNameArKey"
    static let salonNameEnKey = "SalonNameEnKey"
    static let AccessTokenKey = "AccessTokenKey"

}
