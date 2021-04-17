//
//  NewsViewController.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 16/04/21.
//

import UIKit
import Alamofire
import AlamofireImage

final class NewsViewController: UIViewController {
    
    @IBOutlet weak var highLightsCollectionView: UICollectionView!
    private let imageCache = AutoPurgingImageCache(memoryCapacity: 111_111_111, preferredMemoryUsageAfterPurge: 90_000_000)
    private var highlights: [News] = []
    private var highlightsViewModel: HighlightsVewModel!
    
}

// MARK: Life cycle
extension NewsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        highLightsCollectionView.dataSource = self
        highLightsCollectionView.delegate = self
        highLightsCollectionView.backgroundColor = .clear
        
        highlightsViewModel = HighlightsVewModel(highlights: .init())
        highlightsViewModel.delegate = self
        
        highlightsViewModel.loadNews()
        
    }
    
}

// MARK: Helper
extension NewsViewController {
    
    private func imageFromCache(identifier: String) -> UIImage? {
        return imageCache.image(withIdentifier: identifier)
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension NewsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellsAcross: CGFloat = 1
        let spaceBetweenCells: CGFloat = 1
        let dim = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        
        return CGSize(width: dim, height: (dim * 0.7))
    }
    
}

// MARK: UICollectionViewDataSource
extension NewsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        highlights.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let news = highlights[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HighlightsCell", for: indexPath) as! HighlightsCollectionViewCell
        
        cell.descriptionLabel.text = news.title
        cell.titleLabel.text = news.desc
        cell.newsImageView.layer.cornerRadius = 10.0
        
        if let image = imageFromCache(identifier: news.imageURL) {
            
            cell.newsImageView.image = image
            
        } else {
            
            highlightsViewModel.loadImage(url: news.imageURL) {
                
                if let image = self.imageFromCache(identifier: news.imageURL)  {
                    
                    cell.newsImageView.image = image
                    
                }
            }
        }
        
        return cell
    }
    
    
}

extension NewsViewController : HighlightsViewControllerDelegate {
    
    func getInformationBack(data: [News]?) {
        
        guard let highlights = data else { return }
        
        self.highlights = highlights
        
        highLightsCollectionView.reloadData()
        
    }
    
    func getImagesFrom(_ url: String, data: Data?) {
        
        guard let imageFromURL = data else { return }
        
        if let image = UIImage(data: imageFromURL) {
            
            self.imageCache.add(image, withIdentifier: url )
        }
        
    }
    
}


