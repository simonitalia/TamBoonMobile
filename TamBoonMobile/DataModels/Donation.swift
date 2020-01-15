//
//  Donation.swift
//  TamBoonMobile
//
//  Created by Simon Italia on 1/15/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import Foundation

//define donation object
struct Donation: Codable {
    let name: String
    let token: String
    let amount: Int
}
