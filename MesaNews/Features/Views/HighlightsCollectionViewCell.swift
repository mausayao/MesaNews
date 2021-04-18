//
//  HighlightsCollectionViewCell.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 16/04/21.
//

import UIKit

final class HighlightsCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: HighlightsCollectionViewCell.self)
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    weak var likeDelegate: CellDelegate?
    weak var shareDelegate: ShareDelegate?
    
    var row: Int = 0
    var url: String = ""
    
    var like = false {
        didSet {
            changeIcon()
        }
    }
    
    @IBAction func likePressed(_ sender: UIButton) {
        
        like = !like
        likeDelegate?.likeNews(self, index: row, isLike: like)
        changeIcon()
        
    }

    @IBAction func shareButton(_ sender: UIButton) {
        shareDelegate?.share(self, url: url)
    }
}


// MARK: ChangeIconProtocol
extension HighlightsCollectionViewCell: ChangeIconProtocol {
    
    func changeIcon() {
        
        if like {
            
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            
        } else {
            
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    
}
