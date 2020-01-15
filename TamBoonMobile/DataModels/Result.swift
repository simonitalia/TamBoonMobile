//
//  Result.swift
//  TamBoonMobile
//
//  Created by Simon Italia on 1/15/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import Foundation

//define server response object
struct Result: Codable {
    let success: Bool
    let errorCode: String
    let errorMessage: String
    
    //map data object properties to json api parameter names
    enum CodingKeys: String, CodingKey {
        case success
        case errorCode = "error_code"
        case errorMessage = "error_messaege"
    }
}
