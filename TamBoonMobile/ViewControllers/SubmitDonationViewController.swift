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
    @IBOutlet weak var donateButton: UIButton!
    @IBAction func donateButtonTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
           self.donateButton.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
           self.donateButton.transform = .identity
       }
        
        //initiate post of Donation object to remote server
        postDonation()
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var amount: Int?
    var result: Result?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setup UI
        if let formattedAmount = amount?.formatToString() {
            donationAmountLabel.text = "DONATION: "+formattedAmount
        }
    }
    
    func postDonation() {
        self.showSpinner()
        
        //Instantiate Donation with mock data, except for amount
        let name = "John Doe"
        let token = "tokn_test_deadbeef"
        let donation = Donation(name: name, token: token, amount: amount!)
        
        CharitiesController.shared.postDonation(donation) { [unowned self] (result, error) in
            
            if let result = result {
                self.result = result
                self.hideSpinner()

                //handle successful results, good and bad scenarios
                if result.success {
                    self.showAlert(success: true, errorMessage: nil)
   
                } else {
                    self.showAlert(success: false, errorMessage: nil)
                }
            
            //handle network, connection or other issues
            } else {
                if let error = error {
                    self.hideSpinner()
                    let message = error.localizedDescription
                    self.showAlert(success: nil, errorMessage: message)
                }
            }
        }
    }
    
    func showAlert(success: Bool?, errorMessage: String?) {
        DispatchQueue.main.async { [unowned self] in
            var title = ""
            var message = ""
            var ac = UIAlertController()
            var action = UIAlertAction()
            
            if success != nil {
                if success == true {
                    let formattedAmount = self.amount!.formatToString()
                    title = "Thank you! ❤️"
                    message = "Your donation of \(formattedAmount) was received."
                    action = UIAlertAction(title: "OK", style: .default, handler: {
                        action in self.dismissSubmitDonationVC()
                    })
                    
                } else {
                    title = "\(self.result!.errorMessage)"
                    message = "Please try again, or use a different card."
                    action = UIAlertAction(title: "OK", style: .default)
                }
            
            } else if errorMessage != nil {
                title = "We had a problem! ☹️"
                message = "\(errorMessage ?? "")\nPlease try again."
                action = UIAlertAction(title: "OK", style: .default)
            }
            
            ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(action)
            self.present(ac, animated: true)
        }
    }
    
    //dismiss vc and return user to initial VC with unwind segue
    func dismissSubmitDonationVC() {
        self.performSegue(withIdentifier: "DismissSubmitDonationVC", sender: self)
            //created by manually connecting vc icon to exit icon in storyboard
    }
}
