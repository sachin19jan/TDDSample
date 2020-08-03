//
//  DealerDetailTableViewCell.swift
//  CarDelaerSample
//
//  Created by Sachin Bhardwaj on 30/01/20.
//  Copyright © 2020 Sachin Bhardwaj. All rights reserved.
//

import UIKit

protocol CallDelegate: AnyObject {
    func callToDealer(phone: String)
}

class DealerDetailTableViewCell: UITableViewCell {
    weak var delegate: CallDelegate?
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var makeYearLabel: UILabel!
    @IBOutlet weak var dealerDetailLabel: UILabel!
    @IBOutlet weak var callDealerButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func updateDealerCellData(carMake: String,
                              dealerDetail: String,
                              phoneNumber: String) {
        makeYearLabel.text = carMake
        dealerDetailLabel.text = dealerDetail
        callDealerButton.setTitle(phoneNumber, for: .normal)
    }
    @IBAction func callButtonClicked(_ sender: Any) {
        if let buttonTitle = (sender as AnyObject).title(for: .normal) {
            delegate?.callToDealer(phone: buttonTitle)
        }
    }
}
