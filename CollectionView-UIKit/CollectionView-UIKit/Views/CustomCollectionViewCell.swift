//
//  CustomCollectionViewCell.swift
//  CollectionView-UIKit
//
//  Created by Juan Capponi on 10/1/20.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    
    static let identifier = "CustomCollectionViewCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with image: UIImage){
        imageView.image = image
    }

    static func nib() -> UINib {
        return UINib(nibName: "CustomCollectionViewCell", bundle: nil)
    }
    
    public func configue(with viewModel: CellViewModelPictures) {
        imageView.image = viewModel.picture
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
    }
}
