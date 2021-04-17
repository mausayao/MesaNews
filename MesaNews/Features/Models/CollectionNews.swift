//
//  CollectionNews.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 17/04/21.
//

import Foundation

class CollectionNews: NSObject, Decodable {
    
    let pagination: Pagination
    let data: [News]
    
    init(pagination: Pagination, data: [News]) {
        self.pagination = pagination
        self.data = data
    }
    
}
