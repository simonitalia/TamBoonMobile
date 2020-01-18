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
    @IBOutlet weak var charityDonationAmountPickerView: UIPickerView!
    @IBOutlet weak var charityDonateButton: UIButton!
    
    //property to receive data from MainVC and local
    var charity: Charity?
    let donations = Donations().amounts
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //setup VC and fetch of charity logo from remote server
        performSelector(inBackground: #selector(fireGetCharityLogoImage), with: nil)
        charityDonationAmountPickerView.delegate = self
        charityDonationAmountPickerView.dataSource = self
        
        //setup UI
        title = charity?.name ?? "Donate"
    }
    
    //MARK: Custom methods
    @objc func fireGetCharityLogoImage() {

        if let urlString = charity?.logoURL {
            CharitiesController.shared.getCharityLogoImage(from: urlString) { [unowned self] (image) in
                guard let logo = image else { return }
                DispatchQueue.main.async { [unowned self] in
                    self.charityLogoImageView.image = logo
                }
            }
        }
    }
    
    //MARK: PickerView data source and delegate methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
            //sets number of columns
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return donations.count
            //sets number of donation items
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        //set title to dontion amount
        let rowTitle = donations[row]
        
        switch row {
        case 0:
            return rowTitle.formatToString() 
        case 1:
            return rowTitle.formatToString()
        case 2:
            return rowTitle.formatToString()
        case 3:
            return rowTitle.formatToString()
        case 4:
            return rowTitle.formatToString()
        case 5:
            return rowTitle.formatToString()
        default:
            fatalError("Error: Unknown donation amount case")
        }
    }
    
    // MARK: - Navigation
    //setup segue to destination vc
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // get destinaton view controller
        if segue.identifier == "CharityDetailVCToSubmitDonationVC" {
            let vc = segue.destination as! SubmitDonationViewController
            
            //pass donation amount from selected picker row, to destinaiton vc
            let row = charityDonationAmountPickerView.selectedRow(inComponent: 0)
            vc.amount = donations[row]
        
        } else {
            print("Failed to push to SubmitDonationVC")
        }
    }
    
}
