//
//  Pagination.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 17/04/21.
//

import Foundation

final class Pagination: NSObject, Decodable {
    
    var currentPage: Int
    var perPage: Int
    var totalPages: Int
    var totalItems: Int
    
    var now: String = {
        let now = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: now)
    }()
    
    init(currentPage: Int = 1, perPage: Int = 10, totalPages: Int = 0, totalItems: Int = 0) {
        self.currentPage = currentPage
        self.perPage = perPage
        self.totalPages = totalPages
        self.totalItems = totalItems
    }
    
    enum CodingKeys: String, CodingKey {
        
        case currentPage = "current_page"
        case perPage = "per_page"
        case totalPages = "total_pages"
        case totalItems = "total_items"
        
    }
}
