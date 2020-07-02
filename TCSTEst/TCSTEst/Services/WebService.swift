//
//  WebService.swift
//  TCSTEst
//
//  Created by Virant Porwal on 30/06/20.
//  Copyright © 2020 Virant Porwal. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String:Any]

class Webservice {
    
    // Get all information from server
    func getCityDetails(url :URL, callback :@escaping (Error?, (CityDetailModel)?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return   print("Error: invalid HTTP response code")
            }
            guard let data = data else {
                return  print("Error: missing data")
            }
            do {
                guard let string =  String(data: data, encoding: .isoLatin1) else {return}
                guard let perfectData = string.data(using: .utf8, allowLossyConversion: true) else {return}
                
                let decoder = JSONDecoder()
                let cityData = try decoder.decode(CityDetailModel.self, from: perfectData)
                callback(nil, cityData)
            }catch {
                callback(error, nil)
            }
            }.resume()
    }
}
