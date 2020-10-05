//
//  ViewModelDataSource.swift
//  CollectionView-UIKit
//
//  Created by Juan Capponi on 10/1/20.
//

import Foundation
import UIKit

class ViewModelDataSource {
    
    init(){
        }
    
    func pictRetrieve() {
        let headers = Constants.headers
        
        let url = URL(string: Constants.urlPictures)
        guard let requestUrl = url else { fatalError() }

      // Create URL Request
        var request = URLRequest(url: requestUrl)
      
      // Specify HTTP Method to use
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                //print("Response HTTP Status code: \(response.statusCode)")
            }
          
          guard let data = data, let dataString = String(data: data, encoding: .utf8) else {
              print("guard error")
              return
          }
          
          do {
            let jsonAll: JsonAll = try JSONDecoder().decode(JsonAll.self, from: data)
            self.photosArray = jsonAll.photos
          
          } catch let error {
                print("error:\(error.localizedDescription)")
            }
        }
        task.resume()
      
    }
    

    var refreshData = { () -> () in
      }
      
    
    var photosArray: [Photos] = [] {
            didSet {
                refreshData()
            }
        }
    var singlePicture: UIImage = UIImage() {
        didSet {
            refreshData()
        }
    }
    
    func singlepictRetrieve(url: String){
        guard let imageUrl:URL = URL(string: url) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            guard let imageData = try? Data(contentsOf: imageUrl) else {
                return
            }
            self!.singlePicture = UIImage(data: imageData)!
        }
    }
    
}


struct CellViewModelMovies {
    init(videoCreatorName: String, quality: String, link: String, image: String){
        self.name = videoCreatorName
        self.quality = quality
        self.link = link
        self.image = simgleImage(image)
    }
    
    let name : String
    let quality : String
    let link : String
    let image : UIImage!
    
    let simgleImage:(String) -> (UIImage) = { url in
        let data = try! Data(contentsOf: URL(string: url)!)
        return UIImage(data: data)!
        
    }
    
}

struct CellViewModelPictures {
    
    init(photographerName: String, urlSmall : String, medium: String) {
        self.photographerName = photographerName
        self.urlSmall = urlSmall
        self.medium = medium
        self.picture = simgleImage(urlSmall)
    }
    
    let photographerName: String
    let urlSmall : String
    let medium : String
    let picture: UIImage!
    
    let simgleImage:(String) -> (UIImage) = { url in
        let data = try! Data(contentsOf: URL(string: url)!)
        return UIImage(data: data)!
    }
}



struct Constants {
    static let urlPictures = "https://api.pexels.com/v1/search?query=nature&per_page=40"
    static let urlVideos = "https://api.pexels.com/videos/search?query=nature&per_page=40&page=1"
    static let headers = [
        "Authorization": "563492ad6f91700001000001a1c88b38c8244e2299250588ae8f9c44"
    ]
    static let customViewCellHeigth = 110
}
