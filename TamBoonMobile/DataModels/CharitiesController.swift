//
//  CharitiesController.swift
//  TamBoonMobile
//
//  Created by Simon Italia on 1/15/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import Foundation
import UIKit

//this object deals with fetching data from server api endpoints
public struct CharitiesController {
    static var shared = CharitiesController()
        //static global varibale accessible anywhere within app

    let baseURL = URL(string: "https://virtserver.swaggerhub.com/chakritw/tamboon-api/1.0.0/")
    
    //call to api server endpoint to fetch requested data
    func fetchCharitiesList(from endpoint: String, completion: @escaping ([Charity]?, Error?) -> Void) {
        guard let url = baseURL?.appendingPathComponent(endpoint) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let response = response {
                print("Remote server responded with:\n\(response)")
            }
            
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let charityList = try? jsonDecoder.decode(CharityList.self, from: data) {
                print("CharitiesController succesfully fetched data from remote server")
                completion(charityList.charities, nil)
                
                } else {
                    if let error = error {
                        print("CharitiesController failed to fetch data from remote server.\nError: \(error.localizedDescription)")
                        completion(nil, error)
                    }
                }
        }
        
        task.resume()
    }
    
    func fetchCharityLogoImage(from urlString: String, completion: @escaping (UIImage?) -> Void )  {
        
        //force https
//        let secureURL = urlString.secureURL()
        let url = URL(string: urlString)
        
    
        let task = URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            
            if let response = response {
                print("image server response:\n\(response) ")
            }
            
            if let data = data,
                let image = UIImage(data: data) {
                print("successfully fetched image from remote server")
                completion(image)
                
            } else {
                print("failed to fetch image from remote server with error:\n\(error!.localizedDescription))")
                completion(nil)
            }
        }
        
        task.resume()
    }
}


