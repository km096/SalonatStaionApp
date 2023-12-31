//
//  BaseApi.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/16/23.
//

import Foundation
import Alamofire

class BaseAPI<T: TargetType> {
    
    func fetchData<M: Decodable>(target: T, responseClass: M.Type, completion: @escaping (Result<M?, NSError>) -> Void) {
        
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildParams(task: target.task)
        let url = target.baseURL + target.path
        
        AF.request(url, method: method, parameters: params.0, encoding: params.1, headers: headers).responseDecodable(of: M.self) { response in
            
            guard let statusCode = response.response?.statusCode else {
                //Addcustom error
                completion(.failure(NSError()))
                return
            }
            
            if let underlyingError = response.error?.underlyingError {
                if let urlError = underlyingError as? URLError {
                    
                    switch urlError.code {
                        
                    case .timedOut:
                        let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.RequestTimeOut])
                        completion(.failure(error))
                        return
                        
                    case .notConnectedToInternet:
                        let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.offlineInternetConnection])
                        completion(.failure(error))
                        return
                        
                    case .badServerResponse:
                        let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.badServerResponse])
                        completion(.failure(error))
                        return
                        
                    case .badURL:
                        let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.badURL])
                        completion(.failure(error))
                        return
                        
                    default:
                        let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                        completion(.failure(error))
                        return
                    }
                }
            }
            
            if statusCode == 200 {
                
                switch response.result {
                    
                case .success(_):
                    do {
                        guard let data = response.data else {
                            let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                            print(error.localizedDescription)
                            completion(.failure(error))
                            return
                        }
                        
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let responseObj = try decoder.decode(M.self, from: data)
                        completion(.success(responseObj))
                    } catch {
                        let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                        completion(.failure(error))
                    }
                case .failure(_):
                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                    completion(.failure(error))
                }
            } else {
                guard let response = try? response.result.get() as? [String: Any] else {
                    let error = NSError(domain: target.baseURL, code: statusCode, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                    
                    completion(.failure(error))
                    return
                }
                
                let message = response["message"] as? String
                let error = NSError(domain: target.baseURL, code: statusCode, userInfo: [NSLocalizedDescriptionKey: message ?? ""])
                completion(.failure(error))
            }
        }
        
        
    }
    
    private func buildParams(task: Task) -> ([String: Any], ParameterEncoding) {
        switch task {
            
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
}
