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
    func getCharitiesList(completion: @escaping ([Charity]?, Error?) -> Void) {
        let endpoint = APIEndpoint.charities.rawValue
        let url = baseURL?.appendingPathComponent(endpoint)
        let dataTask = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            //capture server response details for debugging
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                print("Remote server reponded with status code: \(httpResponse.statusCode)")
                
                if let data = data,
                    let charityList = try? JSONDecoder().decode(CharityList.self, from: data) {
                    print("Succesfully fetched charities data from remote server, passing data to caller")
                    completion(charityList.charities, nil)
                }

            } else {
                //FUTURE: catch server responsed with invalid status code, trigger alert to user to take action
            }
            
            if let error = error {
                print("Failed to fetch charities data from remote server with error:\n\(error.localizedDescription)")
                completion(nil, error)
                    //also pass error back to caller to take action / notify user
            }
            
        }
        
        dataTask.resume()
    }
    
    func getCharityLogoImage(from urlString: String, completion: @escaping (UIImage?) -> Void )  {
        
        //force https
//        let secureURL = urlString.secureURL()
        let url = URL(string: urlString)
        let dataTask = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            //capture server response details for debugging
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                print("Remote image server reponded with status code: \(statusCode)")
            }
            
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
        
        dataTask.resume()
    }
    
    //MARK: - POST requests
    //post Donation object to remote API server
    func postDonation(_ data: Donation, completion: @escaping (Result?, Error?) -> Void) {
        let endpoint = APIEndpoint.donations.rawValue
        let url = baseURL?.appendingPathComponent(endpoint)

        var requestType = URLRequest(url: url!)
        requestType.httpMethod = "POST"
        requestType.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonEncoder = JSONEncoder()
        requestType.httpBody = try? jsonEncoder.encode(data)
        
        let dataTask = URLSession.shared.dataTask(with: requestType) { (data, response, error) in
            
            //capture server response details for debugging
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 {
            print("Remote server reponded with status code: \(httpResponse.statusCode)")
            
                if let data = data,
                    let result = try? JSONDecoder().decode(Result.self, from: data) {
                    print("POST of Donation data to remote server was successful, passing Result to caller")
                    completion(result, nil)
                }
                
            } else {
                //FUTURE: catch server responsed with invalid status code. Trigger alert to user to take action
            }
            
            if let error = error {
                print("Failed to POST Donation data to remote server with error:\n\(error.localizedDescription)")
                completion(nil, error)
                    //also pass error back to caller to take action / notify user
            }
        }
        
        dataTask.resume()
    }
}


