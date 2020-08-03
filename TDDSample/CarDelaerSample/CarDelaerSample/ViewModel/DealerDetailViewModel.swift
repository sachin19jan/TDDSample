//
//  DealerDetailViewModel.swift
//  CarDelaerSample
//
//  Created by Sachin Bhardwaj on 30/01/20.
//  Copyright © 2020 Sachin Bhardwaj. All rights reserved.
//

import Foundation

typealias CarPriceMileAndAddress = (price: Int, carMileage: Int, dealerCity: String, dealerState: String)
typealias CarModelAndYear = (year: Int, carMake: String, carModel: String)

protocol DealerDetailViewable {
    func getDealerDetails(completion:@escaping ()->Void)
    var  dealerDetailsWebService: DealerDetailsWebservicable { get }
    var  dealerDetailList: [DelaerDetails] { get }
    func getCarModelAndYear(carPriceDetails: CarModelAndYear) -> String
    func getCarPriceMileAndAddress(carMake: CarPriceMileAndAddress) -> String
    
}

class DealerDetailViewModel: DealerDetailViewable {
    var dealerDetailList = [DelaerDetails] ()
    var dealerDetailsWebService: DealerDetailsWebservicable
    
    init(dealerDetailsWebService: DealerDetailsWebservicable = DealerDetailsWebService()) {
        self.dealerDetailsWebService = dealerDetailsWebService
    }
    
    func getDealerDetails(completion: @escaping () -> Void) {
        dealerDetailsWebService.getDealerData { [weak self] dealerDetail in
            self?.dealerDetailList = dealerDetail.listings
            completion()
        }
    }
    
    func getCarModelAndYear(carPriceDetails: CarModelAndYear) -> String {
        let strCarMake = "\(carPriceDetails.year) \(carPriceDetails.carMake) \(carPriceDetails.carModel)"
        return strCarMake
    }
    
    func getCarPriceMileAndAddress(carMake: CarPriceMileAndAddress) -> String {
        let strCarPriceMileAndAddress = "$\(carMake.price) | \(carMake.carMileage) Mi | \(carMake.dealerCity),\(carMake.dealerState)"
        return strCarPriceMileAndAddress
    }
}
