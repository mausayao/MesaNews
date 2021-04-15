//
//  UserViewModel.swift
//  MesaNews
//
//  Created by Maurício de Freitas Sayão on 14/04/21.
//

import Foundation

final class UserViewModel: NSObject {
    
    private let user: User
    @objc private(set) dynamic var isValid: Bool = false
    weak var userViewControllerDelegate: UserViewControllerDelegate?
    
    init(user: User) {
        self.user = user
        super.init()
        
    }
    
    func validate() {
        isValid = !user.name.isEmpty && !user.email.isEmpty && !user.password.isEmpty
    }
    
    func sendUser() {
        let request = UserService().post(user: user)
        
        request.responseDecodable(of: Token.self) { response in
            switch response.result {
            case let .success(result):
                self.userViewControllerDelegate?.getInformationBack(data: result.token)
                
            case .failure(_):
                self.userViewControllerDelegate?.getInformationBack(data: nil)
            }
        }
        
    }
}

extension UserViewModel {
    var name: String {
        set {
            user.name = newValue
        }
        
        get {
            user.name
        }
    }
    
    var email: String {
        set {
            user.email = newValue
        }
        
        get {
            user.email
        }
    }
    
    var password: String {
        set {
            user.password = newValue
        }
        
        get {
            user.password
        }
    }
}

