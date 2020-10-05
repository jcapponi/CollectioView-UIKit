//
//  PictureViewController.swift
//  CollectionView-UIKit
//
//  Created by Juan Capponi on 10/2/20.
//

import UIKit

class PictureViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageSinglePict: UIImageView!
    
    var viewModelDataSource : ViewModelDataSource!
    
    var name: String?
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.label.text = name
        viewModelDataSource = ViewModelDataSource()
        viewModelDataSource.singlepictRetrieve(url: url!)
        binding()

    }
    
    private func binding() {
              viewModelDataSource.refreshData = { [weak self] () in
               DispatchQueue.main.async {
                self?.imageSinglePict?.image = self!.viewModelDataSource.singlePicture
                  }
              }
        }
}

