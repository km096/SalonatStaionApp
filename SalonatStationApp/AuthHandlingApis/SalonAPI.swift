//
//  SalonAPI.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/17/23.
//

import UIKit
import Alamofire

protocol salonAPIProtocol {
    func login(phone: String, completion: @escaping (Result<SalonUser?, NSError>) -> Void)
    func resendCode(phone: String, completion: @escaping (Result<SalonUser?, NSError>) -> Void)
}

class SalonAPI: BaseAPI<SalonNetworking>, salonAPIProtocol {
    
    static let shared = SalonAPI()
    
    func login(phone: String, completion: @escaping (Result<SalonUser?, NSError>) -> Void) {
        self.fetchData(target: .login(phone: phone), responseClass: SalonUser.self) { result in
            completion(result)
        }
    }
    
    
    func resendCode(phone: String, completion: @escaping (Result<SalonUser?, NSError>) -> Void) {
        self.fetchData(target: .resendCode(phone: phone), responseClass: SalonUser.self) { result in
            completion(result)
        }
    }
}
