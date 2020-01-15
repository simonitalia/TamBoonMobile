//
//  ViewController.swift
//  TamBoonMobile
//
//  Created by Simon Italia on 1/15/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func fetchCharitiesList() {
        let endpoint = APIEndPoint.charities.rawValue
        CharitiesController.shared.fetchData(from: endpoint) { (fetchedCharities, error) in
            
            
            
            }
        
    }


}

