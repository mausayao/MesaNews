//
//  ImageDelegate.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 17/04/21.
//

import Alamofire

protocol ImageDelegate: AnyObject {
    
    func getImagesFrom(_ url: String, data: Data?)
}
