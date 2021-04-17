//
//  NewsTableViewCell.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 17/04/21.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: NewsTableViewCell.self)
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    weak var likeDelegate: FavoriteDelegate?
    var row:Int = 0
    
    var like = false {
        didSet {
            changeIcon()
        }
    }
    
    @IBAction func likeButton(_ sender: UIButton) {
        like = !like
        likeDelegate?.likeNews(index: row, isLike: like)
        changeIcon()
        
    }
    
    private func changeIcon() {
        if like {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
}
