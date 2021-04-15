//
//  User.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 14/04/21.
//

import Foundation

final class User: NSObject, Encodable {
    
    var name: String
    var email: String
    var password: String
    
    @objc init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
}
