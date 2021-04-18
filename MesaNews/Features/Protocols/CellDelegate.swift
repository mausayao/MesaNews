//
//  FavoriteDelegate.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 17/04/21.
//

import UIKit

protocol CellDelegate: AnyObject {
    
    func likeNews(_ view: UIView, index: Int, isLike: Bool)
}
