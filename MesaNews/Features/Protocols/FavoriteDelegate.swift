//
//  FavoriteDelegate.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 17/04/21.
//

import UIKit

protocol FavoriteDelegate: AnyObject {
    
    func likeNews(index: Int, isLike: Bool)
}
