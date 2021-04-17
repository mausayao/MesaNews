//
//  HighlightsViewControllerDelegate.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 17/04/21.
//

protocol HighlightsViewControllerDelegate: AnyObject {
    
    func getInformationBack(data: [News]?)
}
