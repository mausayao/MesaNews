//
//  LoginService.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 15/04/21.
//

import Foundation
import Alamofire

final class LoginService {
    
    private let url = "/v1/client/auth/signin"
    
    func post(login: Login) -> DataRequest {
        return AF.request("\(ServiceConstants.baseURL)\(url)", method: .post, parameters: login, encoder: JSONParameterEncoder.default)
    }
    
}
