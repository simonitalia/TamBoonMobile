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
    func formatToString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedString = numberFormatter.string(from: NSNumber(value: self))
        return "THB "+formattedString!
    }
}
