//
//  Data.swift
//  CollectionView-UIKit
//
//  Created by Juan Capponi on 10/1/20.
//

import Foundation

/// PICTURES JSON PARSE
struct JsonAll: Codable {
    let total_results : Int
    let page : Int
    let per_page : Int
    let photos : [Photos]
    let next_page : String
    }


struct Photos: Codable {
    let id: Int
    let width: Int
    let height: Int
    let url: String
    let photographer: String
    let photographer_url: String
    let photographer_id : Int
    let src : PhotoDetails
    let liked : Bool
   
    }

struct PhotoDetails: Codable {
    let original : String
    let large2x : String
    let large:  String
    let medium: String
    let small : String
    let portrait : String
    let landscape :  String
    let tiny : String
}

/// END PICTURES

