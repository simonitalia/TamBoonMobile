//
//  Int+Extension.swift
//  TamBoonMobile
//
//  Created by Simon Italia on 1/17/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import Foundation

extension Int {
    
    //convert format of Int > String
    func formatTitle() -> String {
        return String(format: "THB", self)
    }
    
}
