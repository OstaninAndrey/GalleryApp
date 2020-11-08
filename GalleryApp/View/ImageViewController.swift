//
//  ImageViewController.swift
//  GalleryApp
//
//  Created by Андрей Останин on 30.10.2020.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var fullImageView: UIImageView!
    @IBOutlet weak var loadingStatusLabel: UILabel!
    private var imgVM: ImageViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadContent()
    }
    
    func configure(imgVM: ImageViewModel) {
        self.imgVM = imgVM
    }
    
    func loadContent() {
        self.imgVM?.loadImage(size: .full) { (img) in
            guard let safeImg = img else {
                return
            }
            DispatchQueue.main.async {
                self.fullImageView.image = safeImg
            }
        }
    }
    

}

