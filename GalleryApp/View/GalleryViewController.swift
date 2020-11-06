//
//  ViewController.swift
//  GalleryApp
//
//  Created by Андрей Останин on 30.10.2020.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private let galleryVM = GalleryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        galleryVM.fetchNewPortion{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        configureCollectionView()
        
    }

    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        
        let width = view.bounds.width / 3 - 10
        layout.itemSize = CGSize(width: width, height: width * 2)
        
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: K.ImageCell.nib, bundle: nil), forCellWithReuseIdentifier: K.ImageCell.reuseId)
    }

}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryVM.getElemNumber()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: K.ImageCell.reuseId, for: indexPath) as! ImageCell
        
        if let vm = galleryVM.getElemVM(index: indexPath.item) {
            item.configure(imgVM: vm)
        }
        
        if galleryVM.lastElement(at: indexPath.item) {
            
            galleryVM.fetchNewPortion{
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        
        return item
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = view.bounds.width / 4 - 10
//        return CGSize(width: width, height: width + 20)
//    }
}

