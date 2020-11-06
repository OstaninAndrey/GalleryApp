//
//  ImageViewModel.swift
//  GalleryApp
//
//  Created by Андрей Останин on 30.10.2020.
//

import Foundation

class ImageViewModel {
    private var imageObj: GElement
    
    init(imageObj: GElement) {
        self.imageObj = imageObj
    }
    
    func getTitle() -> String{
        return imageObj.title
    }
}
