//
//  CharityDetailViewController.swift
//  TamBoonMobile
//
//  Created by Simon Italia on 1/16/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class CharityDetailViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //Storyboard outlets
    @IBOutlet weak var charityLogoImageView: UIImageView!
    @IBOutlet weak var charityLogoActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var charityNameLabel: UILabel!
    @IBOutlet weak var charityDonationAmountPickerView: UIPickerView!
    @IBOutlet weak var charityDonateButton: UIButton!
    
    @IBAction func charityDonateButtonTapped(_ sender: Any) {
        
        //Animate button when tapped
        UIView.animate(withDuration: 0.3) {
            self.charityDonateButton.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            self.charityDonateButton.transform = .identity
        }
    }
    
    //property to receive data from MainVC and local
    var charity: Charity?
    let donations = Donations().amounts
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setup VC
        fireFetchCharityLogoImage()
        charityDonationAmountPickerView.delegate = self
        charityDonationAmountPickerView.dataSource = self
        
        //setup UI
        title = "Donate"
        charityNameLabel.text = charity?.name
    }
    
    //MARK: Custom methods
    func fireFetchCharityLogoImage() {
        
        //start activity indicator on logo image view
        animateActivityIndicator(true)

        if let urlString = charity?.logoURL {
            CharitiesController.shared.fetchCharityLogoImage(from: urlString) { [unowned self] (image) in
                guard let logo = image else { return }
            
                DispatchQueue.main.async { [unowned self] in
                    self.charityLogoImageView.image = logo
                }
            }
        }
        
        //stop activity indicator on logo image view
        animateActivityIndicator(false)
    }
    
    func animateActivityIndicator(_ animate: Bool) {
        DispatchQueue.main.async { [unowned self] in
            
            if animate == true {
                self.charityLogoActivityIndicatorView.isHidden = false
                self.charityLogoActivityIndicatorView.alpha = 0.5
                self.charityLogoActivityIndicatorView.startAnimating()
            
            } else {
                self.charityLogoActivityIndicatorView.isHidden = true
                self.charityLogoActivityIndicatorView.alpha = 0
                self.charityLogoActivityIndicatorView.stopAnimating()
            }
        }
    }
    
    //MARK: PickerView data source and delegate methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //set number of columns
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //set number of donation items
        return donations.count + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if row == 0 {
            return "Select Donation Amount:" //set initial picker title
        
        } else {
            let rowTitle = donations[row-1] //set title to dontion amount (minus 1 to start at index 0)
            
            switch row {
            case 1:
                return rowTitle.formatTitle() //sets title row 1 to donations index 0 item
            case 2:
                return rowTitle.formatTitle()
            case 3:
                return rowTitle.formatTitle()
            case 4:
                return rowTitle.formatTitle()
            case 5:
                return rowTitle.formatTitle()
            case 6:
                return rowTitle.formatTitle()
            default:
                fatalError("Error: Unknown donation amount case")
            }
        }
    }
    
}
