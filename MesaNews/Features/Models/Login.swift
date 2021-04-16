//
//  Login.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 15/04/21.
//

import Foundation

final class Login: NSObject, Encodable {
    
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
}
