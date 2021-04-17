//
//  HighlightsVewModel.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 17/04/21.
//

import Foundation

final class HighlightsVewModel: NSObject {
    
    private var highlights: [News]
    weak var delegate: HighlightsViewControllerDelegate?
    private let service = NewsService()
    
    init(highlights: [News]){
        self.highlights = highlights
    }
    
    func loadNews() {
        let request = service.highlights()
        
        request.responseDecodable(of: CollectionHighlights.self) { response in
            switch response.result {
            case let .success(result):
                self.delegate?.getInformationBack(data: result.data)
                
            case .failure(_):
                self.delegate?.getInformationBack(data: nil)
            }
        }
    }
    
    func loadImage(url: String, completion: @escaping () -> Void) {
        let request = service.downloadImage(url: url)
        
        request.responseData { response in
            switch response.result {
            case let .success(result):
                self.delegate?.getImagesFrom(url, data: result)
                completion()
                
            case .failure(_):
                self.delegate?.getImagesFrom(url, data: nil)
            }
        }
        
        
    }
}
