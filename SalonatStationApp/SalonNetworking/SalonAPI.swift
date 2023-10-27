//
//  SalonAPI.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/17/23.
//

import UIKit
import Alamofire

protocol salonAPIProtocol {
    
    func resendCode(phone: String, completion: @escaping (Result<GeneralFormatModel?, NSError>) -> Void)
    
    func verifyUser(parameters: [String: String], completion: @escaping (Result<VerifyUserModel?, NSError>) -> Void)
    
    func salonOrders(status: String, skip: Int, completion: @escaping (Result<SalonOrderModel?, NSError>) -> Void)
    
    func salonService(id: Int, skip: Int, completion: @escaping (Result<SalonServiceModel?, NSError>) -> Void)
    
    func getCategories(completion: @escaping (Result<GetCategoriesModel?, NSError>) -> Void)
    
    func getServices(categoryId: Int, completion: @escaping (Result<GetServicesModel?, NSError>) -> Void)
    
    func salonAddService(dic: [String: Any], completion: @escaping (Result<GeneralFormatModel?,NSError>) -> Void)
}

class SalonAPI: BaseAPI<SalonNetworking>, salonAPIProtocol {
    
    
    
    static let shared = SalonAPI()
    
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
    
    func salonService(id: Int, skip: Int, completion: @escaping (Result<SalonServiceModel?, NSError>) -> Void) {
        self.fetchData(target: .salonServices(id: id, skip: skip), responseClass: SalonServiceModel.self) { result in
            completion(result)
        }
    }
    
    func getCategories(completion: @escaping (Result<GetCategoriesModel?, NSError>) -> Void) {
        self.fetchData(target: .getCategories, responseClass: GetCategoriesModel.self) { result in
            completion(result)
        }
    }
    
    func getServices(categoryId: Int, completion: @escaping (Result<GetServicesModel?, NSError>) -> Void) {
        self.fetchData(target: .getServices(categoryId: categoryId), responseClass: GetServicesModel.self) { result in
            completion(result)
        }
    }
    
    func salonAddService(dic: [String: Any], completion: @escaping (Result<GeneralFormatModel?,NSError>) -> Void) {
        self.fetchData(target: .salonAddServices(dic: dic), responseClass: GeneralFormatModel.self) { result in
            completion(result)
        }
    }
    
}
