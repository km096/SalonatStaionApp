//
//  SalonAPI.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/17/23.
//

import UIKit
import Alamofire

protocol salonAPIProtocol {
    func login(parameters: [String: String], completion: @escaping (Result<SalonUser?, NSError>) -> Void)
    
    func resendCode(phone: String, completion: @escaping (Result<GeneralFormatModel?, NSError>) -> Void)
    
    func verifyUser(parameters: [String: String], completion: @escaping (Result<VerifyUserModel?, NSError>) -> Void)
    
    func salonOrders(status: String, skip: Int, completion: @escaping (Result<SalonOrderModel?, NSError>) -> Void)
    
    func getSalonService(id: Int, completion: @escaping (Result<SalonServiceModel?, NSError>) -> Void)
    
    func getCategories(completion: @escaping (Result<GetCategoriesModel?, NSError>) -> Void)
}

class SalonAPI: BaseAPI<SalonNetworking>, salonAPIProtocol {
    
    static let shared = SalonAPI()
    
    func login(parameters: [String: String], completion: @escaping (Result<SalonUser?, NSError>) -> Void) {
        self.fetchData(target: .login(parameters: parameters), responseClass: SalonUser.self) { result in
            completion(result)
        }
    }
    
    func resendCode(phone: String, completion: @escaping (Result<GeneralFormatModel?, NSError>) -> Void) {
        self.fetchData(target: .resendCode(phone: phone), responseClass: GeneralFormatModel.self) { result in
            completion(result)
        }
    }
    
    func verifyUser(parameters: [String : String], completion: @escaping (Result<VerifyUserModel?, NSError>) -> Void) {
        self.fetchData(target: .verifyUser(parameters: parameters), responseClass: VerifyUserModel.self) { result in
            completion(result)
        }
    }
    
    func salonOrders(status: String, skip: Int, completion: @escaping (Result<SalonOrderModel?, NSError>) -> Void) {
        self.fetchData(target: .salonOrders(status: status, skip: skip), responseClass: SalonOrderModel.self) { result in
            completion(result)
        }
    }
    
    func getSalonService(id: Int, completion: @escaping (Result<SalonServiceModel?, NSError>) -> Void) {
        self.fetchData(target: .getSalonService(id: id), responseClass: SalonServiceModel.self) { result in
            completion(result)
        }
    }
    
    func getCategories(completion: @escaping (Result<GetCategoriesModel?, NSError>) -> Void) {
        self.fetchData(target: .getCategories, responseClass: GetCategoriesModel.self) { result in
            completion(result)
        }
    }
    
}
