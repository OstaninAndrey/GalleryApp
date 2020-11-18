//
//  GElement.swift
//  GalleryApp
//
//  Created by Андрей Останин on 05.11.2020.
//

import Foundation

class GElement {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
    var isLoaded: Bool? = false
    
    init?(json: [String: Any]) {
        self.albumId = json["albumId"] as! Int
        self.id = json["id"] as! Int
        self.title = json["title"] as! String
        self.url = json["url"] as! String
        self.thumbnailUrl = json["thumbnailUrl"] as! String
    }
    
}
