//
//  ShareDelegate.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 18/04/21.
//

import UIKit

protocol ShareDelegate: AnyObject {
    
    func share(_ view: UIView, url: String)
}
