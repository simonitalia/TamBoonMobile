//
//  Charity.swift
//  TamBoonMobile
//
//  Created by Simon Italia on 1/15/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import Foundation

//define charity object
class Charity: Codable {
    var id: Int
    var name: String
    var logoURL: String
    
    //map object properties to json api parameter names
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case logoURL = "logo_url"
    }
    
    //initializer
    init(id: Int, name: String, logoURL: String) {
        self.id = id
        self.name = name
        self.logoURL = logoURL
    }
    
}

struct CharityList: Codable {
    let total: Int
    let charities: [Charity]
    
    enum CodingKeys: String, CodingKey {
        case total
        case charities = "data"
    }
}
