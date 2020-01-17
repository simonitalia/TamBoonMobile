//
//  String+Extension.swift
//  TamBoonMobile
//
//  Created by Simon Italia on 1/16/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import Foundation

extension String {
    
    //convert insecure http url string to secure https url string
    func secureURL() -> URL {
        var components = URLComponents(string: self)
        components?.scheme = "https"
        return components!.url!
    }
}
