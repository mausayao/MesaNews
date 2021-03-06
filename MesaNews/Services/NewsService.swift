//
//  NewsService.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 16/04/21.
//

import Foundation
import Alamofire
import AlamofireImage
import SwiftKeychainWrapper

final class NewsService {
    
    private let urlHighlights = "/v1/client/news/highlights"
    private let urlNews = "/v1/client/news"
    
    
    private func confgureHeaders() -> HTTPHeaders? {
        
        guard let token: String = KeychainWrapper.standard.string(forKey: "token") else { return nil }
        
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        return header
    }
    
    func highlights() -> DataRequest {
        
        return AF.request("\(ServiceConstants.baseURL)\(urlHighlights)", method: .get, headers: confgureHeaders())
    }
    
    func news(currentPage:Int = 1, perPage: Int = 10) -> DataRequest {
        
        return AF.request("\(ServiceConstants.baseURL)\(urlNews)?current_page=\(currentPage)&per_page=\(perPage)",
                          method: .get,
                          headers: confgureHeaders())
    }
    
    func downloadImage(url: String) -> DataRequest {
        
        return  AF.request(url)
        
    }
    
}
