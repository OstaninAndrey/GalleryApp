//
//  NetworkService.swift
//  GalleryApp
//
//  Created by Андрей Останин on 30.10.2020.
//

import Foundation
import Alamofire

class NetworkService {
    
    typealias WebResponse = ([[String: Any]]?, Error?) -> Void
    
    func makeRequest(url: String, completion: @escaping WebResponse) {
        AF.request(url).responseJSON(completionHandler: { (response) in
            
            switch response.result{
            case .success(let value):
                if let jsonArray = value as? [[String: Any]] {
                    completion(jsonArray, nil)
                }
                if let jsonDict = value as? [String: Any] {
                    completion([jsonDict], nil)
                }
            case .failure(_): break
            }
            
        })
        
    }
    
}
