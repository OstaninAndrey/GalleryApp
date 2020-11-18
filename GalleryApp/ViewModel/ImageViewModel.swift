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
    
    private var id: Int {
        return imageObj.id
    }
    
    var title: String {
        return imageObj.title
    }
    
    init(imageObj: GElement) {
        self.imageObj = imageObj
    }
    
    func loadProcessCondition(completion: (String, UIColor) -> Void) {
        var color = UIColor()
        var text = ""
        
        if DatabaseHelper.shared.someEntityExists(id: id) {
            color = UIColor.green
            text = "Saved succesfully!"
        } else {
            color = UIColor.gray
            text = "Loading..."
        }
        completion(text, color)
    }
    
    func loadImage(size: ImageSize, completion: @escaping (UIImage?) -> Void) {     // REFACTOR LATER
        var url = ""
        
        switch size {
        case .thumbNail:
            url = thumbnailUrl
            nwSer.makeRequest(url: url) { (img, _, _) in
                guard let safeImg = img else {
                    completion(nil)
                    return
                }
                
                completion(safeImg)
            }
        case .full:
            url = fullUrl
            let arr = DatabaseHelper.shared.getAllImages()
            if let img = arr.first(where: {$0.id == imageObj.id} ) {
                completion(UIImage(data: img.image!))
                print("Got from DB!")
            } else {
                nwSer.makeRequest(url: url) { [unowned self] (img, _, _) in
                    guard let safeImg = img else {
                        completion(nil)
                        return
                    }
                    
                    completion(safeImg)
                    print("Fetched from API!")
                    self.saveImageToDatabase(image: safeImg)
                }
            }
        }
        
    }
    
    func saveImageToDatabase(image: UIImage) {
        if let imgData = image.pngData() {
            DatabaseHelper.shared.saveLocalImage(id: id, data: imgData)
        }
    }
    
}
