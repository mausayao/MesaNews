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
    
    @IBOutlet weak var newsTableView: UITableView!
    private var newsViewModel: NewsViewModel!
    private var pagination: Pagination!
    private var news: [News] = []
    
}

// MARK: Life cycle
extension NewsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        highLightsCollectionView.dataSource = self
        highLightsCollectionView.delegate = self
        highLightsCollectionView.backgroundColor = .clear
        
        highlightsViewModel = HighlightsVewModel()
        highlightsViewModel.delegate = self
        highlightsViewModel.imageDelegate = self
        
        highlightsViewModel.loadNews()
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
        
        pagination = Pagination()
        newsViewModel = NewsViewModel()
        newsViewModel.loadNews(pagination: pagination)
        newsViewModel.imageDelegate = self
        
        newsViewModel.delegate = self
        
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
        cell.newsImageView.image = .none
        cell.newsImageView.backgroundColor = .lightGray
        cell.likeDelegate = self
        cell.row = indexPath.row
        cell.like = news.isLike
        
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

// MARK: HighlightsViewControllerDelegate
extension NewsViewController : HighlightsViewControllerDelegate {
    
    func getInformationBack(data: [News]?) {
        
        guard let highlights = data else { return }
        
        self.highlights = highlights
        
        highLightsCollectionView.reloadData()
        
    }
    
}

// MARK: UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let news = self.news[indexPath.row]
        
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        
        cell.likeDelegate = self
        cell.descriptionLabel.text = news.title
        cell.titleLabel.text = news.desc
        cell.newsImageView.layer.cornerRadius = 10.0
        cell.newsImageView.image = .none
        cell.newsImageView.backgroundColor = .lightGray
        
        cell.like = news.isLike
        cell.row = indexPath.row
        
        
        if let image = imageFromCache(identifier: news.imageURL) {
            
            cell.newsImageView.image = image
            
        } else {
            
            highlightsViewModel.loadImage(url: news.imageURL) {
                
                if let image = self.imageFromCache(identifier: news.imageURL)  {
                    
                    cell.newsImageView.image = image
                    
                }
            }
        }
        
        if indexPath.row == self.news.count - 1 {
            pagination.currentPage += 1
            if pagination.currentPage <= pagination.totalPages {
                newsViewModel.loadNews(pagination: pagination)
            }
        }
        
        return cell
    }
    
}

// MARK: UITableViewDelegate
extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100.0
    }
}

// MARK: NewsViewControllerDelegate
extension NewsViewController: NewsViewControllerDelegate {
    
    func getInformationBack(data: CollectionNews?) {
        guard let collection = data else { return }
        
        news += collection.data
        pagination = collection.pagination
        
        newsTableView.reloadData()
    }
    
}

// MARK: ImageDelegate
extension NewsViewController: ImageDelegate {
    
    func getImagesFrom(_ url: String, data: UIImage?) {
        
        guard let image = data else { return }
        
        self.imageCache.add(image, withIdentifier: url )
    }
    
}

// MARK: TableViewCellDelegate
extension NewsViewController: CellDelegate {
    
    func likeNews(_ view: UIView, index: Int, isLike: Bool) {
        
        if let _ = view as? HighlightsCollectionViewCell {
            highlights[index].isLike = isLike
        }
        
        if let _ = view as? NewsTableViewCell {
            news[index].isLike = isLike
        }
    }
    
}
