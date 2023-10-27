//
//  TargetType.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/16/23.
//

import Foundation
import Alamofire

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
}

enum Task {
    case requestPlain
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding )
}

protocol TargetType {
    var baseURL: String { get }
//    var baseImageURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: Task { get }
    var headers: [String: String]? { get }
}

