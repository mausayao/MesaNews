//
//  NewsViewControllerDelegate.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 17/04/21.
//


protocol NewsViewControllerDelegate: AnyObject {
    
    func getInformationBack(data: CollectionNews?)
}
