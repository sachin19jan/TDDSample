//
//  DealerDetailsWebService.swift
//  CarDelaerSample
//
//  Created by Sachin Bhardwaj on 29/01/20.
//  Copyright © 2020 Sachin Bhardwaj. All rights reserved.
//

import Foundation

protocol DealerDetailsWebservicable {
    func getDealerData(completion: @escaping (CarDetails) -> Void )
}

struct DealerDetailsWebService: DealerDetailsWebservicable {
    private let session: NetworkSession
    
    init(session: NetworkSession = URLSession.shared) {
        self.session = session
    }
    
    func getDealerData(completion: @escaping (CarDetails) -> Void ) {
        session.getApiCall(url: Enpoint().getDealerDetailsEndPoint()) {
            (data, response, error) in
            guard let data = data, error == nil else { return }
            let list = try? JSONDecoder().decode(CarDetails.self, from: data)
            if let list =  list {
                completion(list)
            }
        }
    }
}
