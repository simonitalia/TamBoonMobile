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
        
    }
    
    //property to receive data from MainVC
    var charity: Charity?
    
    var charityLogo = UIImage()
    let donations = Donations().amounts
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //trigger fetch of charity logo image
//        performSelector(inBackground: #selector(fireFetchCharityLogoImage), with: nil)
        
        //setup UI
        title = "Donate"
        charityNameLabel.text = charity?.name
    }
    
    //MARK: Custom methods
    @objc func fireFetchCharityLogoImage() {
        //start activity inidicator
        charityLogoActivityIndicatorView.isHidden = false
        charityLogoActivityIndicatorView.startAnimating()
        
        if let urlString = charity?.logoURL {
            if let image = CharitiesController.shared.fetchCharityLogoImage(from: urlString) {
                charityLogo = image
                charityLogoActivityIndicatorView.isHidden = true
                charityLogoActivityIndicatorView.stopAnimating()
            }
        }
    }
    
    //MARK: PickerView data source and delegate methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //set number of wheels
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //set number of donation items
        return donations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
        let rowTitle = donations[row] //set title to donation amount
        
        //set each picker row title to donation amount
        switch component {
        case 0:
            return rowTitle.formatTitle() //sets title row 0 to donations index 0 item
        case 1:
            return rowTitle.formatTitle()
        case 2:
            return rowTitle.formatTitle()
        case 3:
            return rowTitle.formatTitle()
        case 4:
            return rowTitle.formatTitle()
            
        default:
            fatalError("Error: Unknown donation amount case")
        }
        
    }
    

}
