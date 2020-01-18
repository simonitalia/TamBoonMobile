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
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
            //dimiss view
    }
    
    @IBAction func donateButtonTapped(_ sender: Any) {
        postDonation()
            //trigger post donation
    }
    
    var amount: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup UI
        if let formattedAmount = amount?.formatToString() {
            donationAmountLabel.text = "DONATION: "+formattedAmount
        }

    }
    
    func postDonation() {
        //Donation instantiated with mock data, except for donation amount
        let name = "John Doe"
        let token = "tokn_test_deadbeef"
        let donation = Donation(name: name, token: token, amount: amount!)
        
        //trigger post
        CharitiesController.shared.postDonation(donation) { [unowned self] (response, error) in
            if let response = response {
                
            }
            
        
        
        }
            
    }
    
    
}
