//
//  GalleryViewModel.swift
//  GalleryApp
//
//  Created by Андрей Останин on 30.10.2020.
//

import UIKit

class GalleryViewModel {
    private let nwSer = NetworkService()
    private var galleryElements: [ImageViewModel] = []
    private var start = 0
    private let limit = K.Paging.size
    
    var elemNumber: Int {
        return galleryElements.count
    }

    func getElemVM(index: Int) -> ImageViewModel? {
        return galleryElements[index]
    }
    
    func lastElement(is index: Int) -> Bool{
        return index == galleryElements.count-1 ? true:false
    }
    
    func fetchNewPortion(completion: @escaping () -> Void) {
        let url = "http://jsonplaceholder.typicode.com/photos?_start=\(start)&_limit=\(limit)"
        
        nwSer.makeRequest(url: url) { [unowned self] (_, jsonArr, err) in
            guard let array = jsonArr else {
                return
            }
            self.start = self.limit
            
            array.forEach{ json in
                if let element = GElement(json: json) {
                    self.galleryElements.append(ImageViewModel(imageObj: element))
                }
            }
            //print(self.galleryElements.count)
            completion()
        }
    }
    
    func openFullImage(at index: Int) {
        guard index <= galleryElements.count else {
            return
        }
            
    }
    
}
