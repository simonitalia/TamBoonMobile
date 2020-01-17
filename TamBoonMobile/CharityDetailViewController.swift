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
        performSelector(inBackground: #selector(fireFetchCharityLogoImage), with: nil)
        charityDonationAmountPickerView.delegate = self
        charityDonationAmountPickerView.dataSource = self
        
        //setup UI
        title = "Donate"
        charityNameLabel.text = charity?.name
    }
    
    //MARK: Custom methods
    @objc func fireFetchCharityLogoImage() {

        if let urlString = charity?.logoURL {
            CharitiesController.shared.fetchCharityLogoImage(from: urlString) { [unowned self] (image) in
                guard let logo = image else { return }
                DispatchQueue.main.async { [unowned self] in
                    self.charityLogoImageView.image = logo
                }
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
                return rowTitle.formatToString() //sets title row 1 to donations index 0 item
            case 2:
                return rowTitle.formatToString()
            case 3:
                return rowTitle.formatToString()
            case 4:
                return rowTitle.formatToString()
            case 5:
                return rowTitle.formatToString()
            case 6:
                return rowTitle.formatToString()
            default:
                fatalError("Error: Unknown donation amount case")
            }
        }
    }
    
}
