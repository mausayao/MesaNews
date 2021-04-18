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
    var url: String
    
    var isLike: Bool = false
    
    init(title: String, description: String, imageURL: String, url: String) {
        self.title = title
        self.desc = description
        self.imageURL = imageURL
        self.url = url
    }
    
    enum CodingKeys: String, CodingKey {
        
        case title
        case desc = "description"
        case imageURL = "image_url"
        case url 
        
    }
    
}
