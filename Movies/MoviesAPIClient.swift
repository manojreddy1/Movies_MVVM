//
//  MoviesAPIClient.swift
//  Movies
//
//  Created by Vaayoo on 02/07/19.
//  Copyright © 2019 Vaayoo. All rights reserved.
//

import UIKit
import Alamofire
class MoviesAPIClient: NSObject {
    func fetchMovies<T: Decodable>(url: String, completion: @escaping ([T]) -> Void){
        let header = ["Content-Type": "application/json"]
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        manager.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            switch(response.result) {
            case .success(let value):
                print(value)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if  let dataa = response.data{
                    if let json = try? decoder.decode(T.self, from: dataa){
                        completion([json])
                    }
                }
                //completion(self.manyMovies)
                break
            case .failure(let error):
                print("Failure : \(response.result.error!)")
                print("let error : \(error.localizedDescription)")
                break
            }
        }
        
    }
}
