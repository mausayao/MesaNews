//
//  HighlightsCollectionViewCell.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 16/04/21.
//

import UIKit

class HighlightsCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: HighlightsCollectionViewCell.self)
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
}
