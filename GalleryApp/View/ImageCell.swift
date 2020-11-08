//
//  ImageCell.swift
//  GalleryApp
//
//  Created by Андрей Останин on 30.10.2020.
//

import UIKit

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var isLoadedLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    private var imgVM: ImageViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = ""
        isLoadedLabel.textColor = UIColor.systemGray
    }
    
    func configure(imgVM: ImageViewModel) {
        self.imgVM = imgVM
        titleLabel.text = imgVM.title
        
        // start loading photo
        imgVM.loadImage(size: .thumbNail) { (img) in
            guard let safeImg = img else {
                return
            }
            DispatchQueue.main.async {
                self.imageView.image = safeImg
            }
        }
    }
    
    
}
