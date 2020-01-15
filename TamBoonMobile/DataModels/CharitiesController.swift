//
//  CharitiesController.swift
//  TamBoonMobile
//
//  Created by Simon Italia on 1/15/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import Foundation

//this object deals with fetching data from server api endpoints
public struct CharitiesController {
    static var shared = CharitiesController()
        //static global varibale accessible anywhere within app
    var charities = [CharityList]()
    let baseURL = URL(string: "https://virtserver.swaggerhub.com/chakritw/tamboon-api/1.0.0/")
    
    //call to api server endpoint to fetch requested datat. Data type set to Any so function is generic
    func fetchData(from endpoint: String, completion: @escaping ([Any]?, Error?) -> Void) {
        guard let url = baseURL?.appendingPathComponent(endpoint) else {return}
        
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let result = try? jsonDecoder.decode(CharityList.self, from: data) {
                completion(result.charities, nil)
                
            } else {
                if let error = error {
                    completion(nil, error)
                }
            }
        }
        
        task.resume()
    }
}
