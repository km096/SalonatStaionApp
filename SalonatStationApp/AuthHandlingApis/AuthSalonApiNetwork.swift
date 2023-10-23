//
//  AuthSalonApiNetwork.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/16/23.
//

import Foundation
import Alamofire

enum SalonNetworking {
    case login(parameters: [String: String])
    case resendCode(phone: String)
    case verifyUser(parameters: [String: String])
    case salonOrders(status: String, skip: Int)
    case getCategories
    case getSalonService(id: Int)
}

extension SalonNetworking: TargetType {
    
    var baseURL: String {
        return Constants.baseURL
    }
    
    var path: String {
        switch self {
            
        case .login:
            return "/user/login"
        case .resendCode:
            return "/Back/resend"
        case .verifyUser:
            return "/Back/verify"
        case .salonOrders(status: let status, skip: let skip):
            return "/Back/orders?status=\(status)&skip=\(skip)"
        case .getCategories:
            return "/Back/categories"
        case .getSalonService(id: let id):
            return "/Back/services?center_id=\(id)"
//            return "/Back/center/\(id)/services?skip=\(skip)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            
        case .login, .resendCode, .verifyUser:
            return .post
        
        case .salonOrders, .getCategories, .getSalonService:
            return .get
        }
        
    }
    
    var task: Task {
        switch self {
            
        case .login(parameters: let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .resendCode(phone: let phone):
            return .requestParameters(parameters: ["phone": phone], encoding: JSONEncoding.default)
        case .verifyUser(parameters: let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .salonOrders, .getCategories, .getSalonService:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return NetworkHelper.shared.getHeaders()
    }
    
    
}
