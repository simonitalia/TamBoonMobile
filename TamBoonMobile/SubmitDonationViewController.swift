//
//  SubmitDonationViewController.swift
//  TamBoonMobile
//
//  Created by Simon Italia on 1/18/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class SubmitDonationViewController: UIViewController {
    
    @IBOutlet weak var donationAmountLabel: UILabel!
    @IBAction func donateButtonTapped(_ sender: Any) {
        
    }
    
    var donationAmount: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup UI
        if let formattedAmount = donationAmount?.formatToString() {
            donationAmountLabel.text = "DONATION: "+formattedAmount
        }

    }
    
    
    

    
}
