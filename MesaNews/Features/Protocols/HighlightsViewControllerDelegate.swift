//
//  HighlightsViewControllerDelegate.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 17/04/21.
//
import Alamofire

protocol HighlightsViewControllerDelegate: AnyObject {
    
    func getInformationBack(data: [News]?)
    
    func getImagesFrom(_ url: String, data: Data?)
}
