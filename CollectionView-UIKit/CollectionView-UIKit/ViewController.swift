//
//  ViewController.swift
//  CollectionView-UIKit
//
//  Created by Juan Capponi on 10/1/20.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    
    
    var viewModelDataSource: ViewModelDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "PICTURES"
        
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
        
        collectionView.register(CustomCollectionViewCell.nib(), forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        viewModelDataSource = ViewModelDataSource()
        viewModelDataSource.pictRetrieve()
        binding()
    }
   
    private func binding() {
        self.activity.startAnimating()
           viewModelDataSource.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                   self?.collectionView.reloadData()
                   self?.activity.stopAnimating()
                   self?.activity.isHidden = true
               }
           }
       }
}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let model = viewModelDataSource.photosArray[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "storyPictureVC") as! PictureViewController
        vc.name = model.photographer
        vc.url = model.src.medium
        navigationController?.pushViewController(vc, animated: true)
        
    }
}


extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModelDataSource.photosArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
  
        let model = viewModelDataSource.photosArray[indexPath.row]
        let viewModel = CellViewModelPictures.init(photographerName: model.photographer, urlSmall: model.src.small, medium: model.src.medium)
        cell.configue(with: viewModel)
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.main.bounds
        return CGSize(width: (screenSize.width/3) - 8 , height: 100)
    }
}
