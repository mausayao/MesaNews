//
//  Token.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 14/04/21.
//

import Foundation

class Token: NSObject, Decodable {
    
    let token: String
    
    init(token: String) {
        self.token = token
    }
    
}
