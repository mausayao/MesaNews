//
//  NewsViewModel.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 17/04/21.
//

import Foundation

final class NewsViewModel: NSObject {
    
    private var collection: CollectionNews
    weak var delegate: NewsViewControllerDelegate?
    weak var imageDelegate: ImageDelegate?
    private let service = NewsService()
    
    init(collection: CollectionNews){
        self.collection = collection
    }
    
    func loadNews(pagination: Pagination) {
        
        let request = service.news(currentPage: pagination.currentPage,
                                   perPage: pagination.perPage)
        
        request.responseDecodable(of: CollectionNews.self) { response in
            switch response.result {
            
            case let .success(result):
                self.delegate?.getInformationBack(data: result)
                
            case .failure(_):
                self.delegate?.getInformationBack(data: nil)
            }
        }
    }
    
    func loadImage(url: String, completion: @escaping () -> Void) {
        let request = service.downloadImage(url: url)
        
        request.responseImage { response in
            DispatchQueue.main.async {
                
                switch response.result {
                
                case let .success(result):
                    self.imageDelegate?.getImagesFrom(url, data: result)
                    completion()
                    
                case .failure(_):
                    self.imageDelegate?.getImagesFrom(url, data: nil)
                }
            }
        }
    }
}
