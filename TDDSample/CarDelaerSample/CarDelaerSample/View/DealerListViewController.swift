//
//  ViewController.swift
//  CarDelaerSample
//
//  Created by Sachin Bhardwaj on 29/01/20.
//  Copyright © 2020 Sachin Bhardwaj. All rights reserved.
//

import UIKit

class DealerListViewController: UIViewController {
    
    @IBOutlet weak var dealerDetailTableView: UITableView!
    
    lazy var viewModel: DealerDetailViewModel = {
        let viewModel = DealerDetailViewModel(dealerDetailsWebService: DealerDetailsWebService())
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getDealerDeatails()
    }
    
    func getDealerDeatails() {
        viewModel.getDealerDetails {
            DispatchQueue.main.async { [weak self] in 
                self?.dealerDetailTableView.reloadData()
            }
        }
    }
    
    func setupTableView() {
        dealerDetailTableView.register(UINib(nibName: "DealerDetailTableViewCell", bundle: nil),
                                       forCellReuseIdentifier: "DealerDetailTableViewCell")
    }
}

extension DealerListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dealerDetailList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dealerDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DealerDetailTableViewCell",
                                                                            for: indexPath) as? DealerDetailTableViewCell
            else { return UITableViewCell() }
        let carDetail = viewModel.dealerDetailList[indexPath.row]
        let carMake = viewModel.getCarModelAndYear(carPriceDetails:(year: carDetail.year,
                                                                    carMake: carDetail.make,
                                                                    carModel: carDetail.model))
        let carPriceAddress = viewModel.getCarPriceMileAndAddress(carMake: (price: carDetail.currentPrice,
                                                                            carMileage: carDetail.mileage,
                                                                            dealerCity: carDetail.dealer.city,
                                                                            dealerState: carDetail.dealer.state))
        dealerDetailTableViewCell.updateDealerCellData(carMake: carMake ,
                                                       dealerDetail: carPriceAddress,
                                                       phoneNumber: carDetail.dealer.phone)
        dealerDetailTableViewCell.delegate = self
        return dealerDetailTableViewCell
    }
    
    /*
    func loadImageDealerCell(dealerCell: DealerDetailTableViewCell, urlString: String) {
        let url = URL(string: urlString)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                dealerCell.carImageView?.image = UIImage(data: data!)
            }
        }
    } */
}

extension UIViewController: CallDelegate {
    func callToDealer(phone: String) {
        if let url = NSURL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.openURL(url as URL)
        }
    }
}
