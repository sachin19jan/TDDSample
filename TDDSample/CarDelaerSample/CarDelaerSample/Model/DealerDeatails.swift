//
//  DealerDeatails.swift
//  CarDelaerSample
//
//  Created by Sachin Bhardwaj on 29/01/20.
//  Copyright © 2020 Sachin Bhardwaj. All rights reserved.
//

import Foundation

struct CarDetails: Decodable {
    let listings : [DelaerDetails]
}

struct DelaerDetails: Decodable {
   // let carImage: CarImage
    let year: Int
    let make: String
    let model: String
    let currentPrice: Int
    let mileage: Int
    let dealer : Dealer
    
    enum CodingKeys: String, CodingKey {
       // case carImage =  "images"
        case year, make, model, currentPrice, mileage, dealer
    }
}

struct Dealer: Decodable {
    let city: String
    let state: String
    let phone: String
}

struct CarImage: Decodable {
     let firstPhoto : FirstPhoto
}

struct FirstPhoto: Decodable {
    let largeImage: String
    let mediumImage: String
    let smallImage: String
    
    enum CodingKeys: String, CodingKey {
        case largeImage =  "large"
        case mediumImage =  "medium"
        case smallImage =  "small"
    }
}



