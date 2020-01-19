//
//  SubmitDonationViewController.swift
//  TamBoonMobile
//
//  Created by Simon Italia on 1/18/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class SubmitDonationViewController: UIViewController {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
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
        
//        animateActivityIndicator(animate: true)
        
        //Instantiate Donation with mock data, except for amount
        let name = "John Doe"
        let token = "tokn_test_deadbeef"
        let donation = Donation(name: name, token: token, amount: amount!)
        
        CharitiesController.shared.postDonation(donation) { [unowned self] (result, error) in
            if let result = result {
                self.result = result
                self.showAlert(success: true, errorMessage: nil)
            
            } else {
                if let _ = error {
                    let message = error?.localizedDescription
                    self.showAlert(success: false, errorMessage: message)
                       
                }
            }
        }
        
//        self.animateActivityIndicator(animate: false)
        
    }
    
    func animateActivityIndicator(animate: Bool) {
        DispatchQueue.main.async { [unowned self] in
            
            if animate == true {
                self.activityIndicatorView.isHidden = false
                self.activityIndicatorView.alpha = 1.0
                self.activityIndicatorView.startAnimating()
                self.view.isUserInteractionEnabled = false
                
            
            } else {
                self.activityIndicatorView.isHidden = true
                self.activityIndicatorView.alpha = 0
                self.activityIndicatorView.stopAnimating()
                self.view.isUserInteractionEnabled = true
            }
        }
    }
    
    func showAlert(success: Bool, errorMessage: String?) {
        DispatchQueue.main.async { [unowned self] in
            if success == true {
                let formattedAmount = self.amount!.formatToString()
                let ac = UIAlertController(title: "Thank you ❤️", message: "Your donation of \(formattedAmount) was received!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                    action in self.dismissSubmitDonationVC()
                }))
                
                self.present(ac, animated: true)
                
            } else {
                let ac = UIAlertController(title: "We had a problem ☹️", message: "\(errorMessage ?? "")\nPlease try again.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(ac, animated: true)
            }
        }
    }
    
    //dismiss vc and return user to initial VC with unwind segue
    func dismissSubmitDonationVC() {
        self.performSegue(withIdentifier: "DismissSubmitDonationVC", sender: self)
            //created by manually connecting vc icon to exit icon in storyboard
    }
    
    
}
