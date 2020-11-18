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
    
    private var image: UIImage? {
        didSet {
            fullImageView.image = image
            // stopAnimating and hide activity indicator
            
            imgVM?.loadProcessCondition(completion: { (text, _) in
                loadingStatusLabel.text = text
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgVM?.loadProcessCondition(completion: { (text, _) in
            loadingStatusLabel.text = text
        })
    }
    
    func configure(imgVM: ImageViewModel, completion: @escaping () -> Void) {
        self.imgVM = imgVM
        loadContent{
            completion()
        }
    }
    
    private func loadContent(completion: @escaping () -> Void) {
        self.imgVM?.loadImage(size: .full) { (img) in
            guard let safeImg = img else {
                return
            }
            DispatchQueue.main.async {
                self.image = safeImg
                completion()
            }
        }
    }
    

}

