//
//  CityModel.swift
//  TCSTEst
//
//  Created by Virant Porwal on 30/06/20.
//  Copyright © 2020 Virant Porwal. All rights reserved.
//

import Foundation



struct CityModel: Codable {
    
    var title :String?
    var description :String?
    var image :String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case image = "imageHref"
    }
}
