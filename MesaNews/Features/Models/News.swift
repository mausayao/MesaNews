//
//  News.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 16/04/21.
//

import Foundation

final class News: NSObject, Decodable {
    
    var title: String
    var desc: String
    var imageURL: String
    
    init(title: String, description: String, imageURL: String) {
        self.title = title
        self.desc = description
        self.imageURL = imageURL
    }
    
    enum CodingKeys: String, CodingKey {
        
           case title
           case desc = "description"
           case imageURL = "image_url"
          
       }
    
}
