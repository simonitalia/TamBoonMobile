//
//  CharitiesController.swift
//  TamBoonMobile
//
//  Created by Simon Italia on 1/15/20.
//  Copyright © 2020 SDI Group Inc. All rights reserved.
//

import Foundation
import UIKit

//this struct manages fetching data from the remote servers
public struct CharitiesController {
    static var shared = CharitiesController()
        //static global varibale accessible anywhere within app

    let baseURL = URL(string: "https://virtserver.swaggerhub.com/chakritw/tamboon-api/1.0.0/")
    
    //MARK: GET requests
    //call to api server endpoint to fetch requested data
    func getCharitiesList(completion: @escaping ([Charity]?) -> Void) {
        let endpoint = APIEndpoint.charities.rawValue
        guard let url = baseURL?.appendingPathComponent(endpoint) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            
            if let data = data,
                let charityList = try? jsonDecoder.decode(CharityList.self, from: data) {
                print("Succesfully fetched charities data from remote server, passing data to caller")
                completion(charityList.charities)
                
            } else {
                if let error = error {
                    print("Failed to fetch charities data from remote server with error:\n\(error.localizedDescription)")
                    completion(nil)
                }
            }
        }
        
        task.resume()
    }
    
    func getCharityLogoImage(from urlString: String, completion: @escaping (UIImage?) -> Void )  {
        
        //force https
//        let secureURL = urlString.secureURL()
        let url = URL(string: urlString)
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let data = data,
                let image = UIImage(data: data) {
                print("Successfully fetched image from remote server, passing data to caller")
                completion(image)
                
            } else {
                if let error = error {
                    print("Failed to fetch image from remote server with error:\n\(error.localizedDescription))")
                    completion(nil)
                }
            }
        }
        
        task.resume()
    }
    
    //MARK: - POST requests
    //post Donation object to remote API server
    func postDonation(_ data: Donation, completion: @escaping (Result?, Error?) -> Void) {
        let endpoint = APIEndpoint.donations.rawValue
        guard let url = baseURL?.appendingPathComponent(endpoint) else {return}

        var requestType = URLRequest(url: url)
        requestType.httpMethod = "POST"
        requestType.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        
        //add data to url
        requestType.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: requestType) {
            (data, response, error) in
            
            //capture server response details for debugging
//            if let response = response {
//                print("Remote server reponded with\n\(response)")
//            }
            
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let result = try? jsonDecoder.decode(Result.self, from: data) {
                print("POST of Donation data to remote server was successful, passing Result to caller")
                completion(result, nil)
                
            } else {
                if let error = error {
                    print("Failed to POST Donation data to remote server with error:\n\(error.localizedDescription))")
                    completion(nil, error)
                        //also pass error back to caller to take action / notify user
                }
            }
        }
        
        task.resume()
    }
}


