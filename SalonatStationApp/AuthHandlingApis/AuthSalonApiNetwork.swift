//
//  AuthSalonApiNetwork.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/16/23.
//

import Foundation
import Alamofire

enum SalonNetworking {
    case login(phone: String)
    case resendCode(phone: String)
    case userConfirm(parameters: [String: String])
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
        case .userConfirm:
            return "/Back/verify"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            
        case .login, .resendCode, .userConfirm:
            return .post
        }
        
    }
    
    var task: Task {
        switch self {
            
        case .login(phone: let phone):
            return .requestParameters(parameters: ["phone": phone], encoding: JSONEncoding.default)
        case .resendCode(phone: let phone):
            return .requestParameters(parameters: ["phone": phone], encoding: JSONEncoding.default)
        case .userConfirm(parameters: let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return NetworkHelper.shared.getHeaders()
    }
    
    
}
