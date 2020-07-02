//
//  CityViewModel.swift
//  TCSTEst
//
//  Created by Virant Porwal on 30/06/20.
//  Copyright © 2020 Virant Porwal. All rights reserved.
//

import Foundation

protocol CityViewModelProtocol {
    func didUpdateCityDetails(cityDetail: CityDetailModel) // Method to update table view
    func didUpdateCityTitle(cityTitle: String)   // Method to update navigation title
}

class CityViewModel{
    
    var delegate: CityViewModelProtocol?
    let webService = Webservice()
    var cityModel : [CityModel] = []  //Pass all city Data from this var to view controller
    let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
   
    // To get all information from Web service class to viewModel Class
    func getCityDetailsInVeiwModel() {
        
        webService.getCityDetails(url: url) { error, cityDetailModel  in
            
            if let cityDetailModelResult = cityDetailModel {
                self.cityModel = cityDetailModelResult.rows
                self.delegate?.didUpdateCityTitle(cityTitle: cityDetailModelResult.title!)
                self.delegate?.didUpdateCityDetails(cityDetail: cityDetailModelResult)
            }
        }
    }
    
}
