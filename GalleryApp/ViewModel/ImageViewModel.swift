//
//  ImageViewModel.swift
//  GalleryApp
//
//  Created by Андрей Останин on 30.10.2020.
//

import UIKit

class ImageViewModel {
    private var imageObj: GElement
    private let nwSer = NetworkService()
    
    private var thumbnailUrl: String {
        return imageObj.thumbnailUrl
    }
    
    private var fullUrl: String {
        return imageObj.url
    }
    
    enum ImageSize {
        case thumbNail
        case full
    }
    
    var title: String {
        return imageObj.title
    }
    
    init(imageObj: GElement) {
        self.imageObj = imageObj
    }
    
    func loadImage(size: ImageSize, completion: @escaping (UIImage?) -> Void) {
        var url = ""
        
        switch size {
        case .thumbNail:
            url = thumbnailUrl
        case .full:
            url = fullUrl
        }
        
        nwSer.makeRequest(url: url) { (img, _, _) in
            guard let safeImg = img else {
                completion(nil)
                return
            }
            
            completion(safeImg)
        }
    }
    
}
