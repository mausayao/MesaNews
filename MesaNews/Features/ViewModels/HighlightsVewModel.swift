//
//  HighlightsVewModel.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 17/04/21.
//

import Foundation

final class HighlightsVewModel: NSObject {
    
    weak var delegate: HighlightsViewControllerDelegate?
    weak var imageDelegate: ImageDelegate?
    private let service = NewsService()
    
    func loadNews() {
        let request = service.highlights()
        
        request.responseDecodable(of: CollectionHighlights.self) { response in
            DispatchQueue.main.async {
                switch response.result {
                
                case let .success(result):
                    
                    self.delegate?.getInformationBack(data: result.data)
                    
                case .failure(_):
                    
                    self.delegate?.getInformationBack(data: nil)
                }
            }
        }
    }
    
    func loadImage(url: String, completion: @escaping () -> Void) {
        let request = service.downloadImage(url: url)
        
        request.responseImage { response in
            
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
