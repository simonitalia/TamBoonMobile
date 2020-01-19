//
//  ViewController+Extensions.swift
//  TamBoonMobile
//
//  Created by Simon Italia on 1/20/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import UIKit

fileprivate var activityView: UIView?

extension UIViewController {
    
    func showSpinner() {
        DispatchQueue.main.async {
            //setup spinner container view
            activityView = UIView(frame: self.view.bounds)
            activityView!.backgroundColor = UIColor(white: 0, alpha: 0.2)
            
            //creeat spinner and add to its container view
            let spinner = UIActivityIndicatorView(style: .large)
            spinner.center = activityView!.center
            spinner.startAnimating()
            activityView!.addSubview(spinner)
            
            //add activity view to self
            self.view.addSubview(activityView!)
        }
    }
    
    func hideSpinner() {
        DispatchQueue.main.async {
            activityView!.removeFromSuperview()
            activityView = nil
        }
    }
}
