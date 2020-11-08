//
//  NetworkService.swift
//  GalleryApp
//
//  Created by Андрей Останин on 30.10.2020.
//

import UIKit
import Alamofire
import AlamofireImage

class NetworkService {
    
    typealias WebResponse = (UIImage?, [[String: Any]]?, Error?) -> Void
    
    func makeRequest(url: String, completion: @escaping WebResponse) {
        
        AF.request(url).responseImage { (response) in
            if case .success(let image) = response.result {
                completion(image, nil, nil)
                return
            }
        }
        
        AF.request(url).responseJSON(completionHandler: { (response) in
            switch response.result{
            case .success(let value):
                if let jsonArray = value as? [[String: Any]] {
                    completion(nil, jsonArray, nil)
                    return
                }
                if let jsonDict = value as? [String: Any] {
                    completion(nil, [jsonDict], nil)
                    return
                } 
            case .failure(let err):
                completion(nil, nil, err)
                return
            }
        })
        
    }
    
}
