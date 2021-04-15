//
//  UserService.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 14/04/21.
//

import Foundation
import Alamofire

final class UserService {
    
    private let url = "/v1/client/auth/signup"
    
    func post(user: User) -> DataRequest {
        return AF.request("\(ServiceConstants.baseURL)\(url)", method: .post, parameters: user, encoder: JSONParameterEncoder.default)
    }
}
