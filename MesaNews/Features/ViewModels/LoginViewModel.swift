//
//  LoginViewModel.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 15/04/21.
//

import Foundation

final class LoginViewModel: NSObject {
    
    private var login: Login
    @objc private(set) dynamic var isValid: Bool = false
    weak var delegate: LoginViewControllerDelegate?
    
    init(login: Login) {
        self.login = login
    }
    
    func validate() {
        isValid = !login.email.isEmpty
            && Utils.isValidEmail(login.email)
            && !login.password.isEmpty
    }
    
    func sendLogin() {
        let request = LoginService().post(login: login)
        
        request.responseDecodable(of: Token.self) { response in
            
            switch response.result {
            
            case let .success(result):
                
                self.delegate?.getInformationBack(data: result.token)
                
            case .failure(_):
                
                self.delegate?.getInformationBack(data: nil)
            }
        }
    }
    
}

extension LoginViewModel {
    
    var email: String {
        set {
            login.email = newValue
        }
        
        get {
            login.email
        }
    }
    
    var password: String {
        set {
            login.password = newValue
        }
        
        get {
            login.password
        }
    }
    
}
