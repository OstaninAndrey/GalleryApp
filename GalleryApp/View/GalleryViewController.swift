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
        
        let width = view.frame.width / 3 - 10
        layout.itemSize = CGSize(width: width, height: width * 1.5)
        
        collectionView.collectionViewLayout = layout
        collectionView.register(UINib(nibName: K.ImageCell.nib, bundle: nil), forCellWithReuseIdentifier: K.ImageCell.reuseId)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ImageViewController
        
        vc.configure(imgVM: sender as! ImageViewModel)
    }

}

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.fullImageSegue, sender: galleryVM.getElemVM(index: indexPath.item))
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryVM.elemNumber
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
}

