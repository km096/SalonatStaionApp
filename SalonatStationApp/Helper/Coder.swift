//
//  Coder.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/17/23.
//

import Foundation


class Coder {
    
    func decode<T: Codable>(toType type: T.Type, jsonData: Data) -> T? {
        let decoder = JSONDecoder()
        
        do {
            let objecet = try decoder.decode(type, from: jsonData)
            return objecet
        } catch {
            print("error decoding: \(error.localizedDescription)")
        }
        return nil
    }
    
    func encode<T: Codable>(fromCodable codable: T) -> Data? {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(codable)
            return data
        } catch {
            print("error encoding: \(error.localizedDescription)")
        }
        return nil
    }
}
