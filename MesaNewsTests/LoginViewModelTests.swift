//
//  LoginViewModelTests.swift
//  MesaNewsTests
//
//  Created by Maurício de Freitas Sayão on 18/04/21.
//

import XCTest
@testable import MesaNews

final class LoginViewModelTests: XCTestCase {
    
    var loginViewModel: LoginViewModel!
    
    override func setUp() {
        super.setUp()
        
        loginViewModel = LoginViewModel(login: .init(email: "", password: ""))
    }
    
    
    func testLoginIsValid() {
    
        loginViewModel.email = "mauricio@sayao.com"
        loginViewModel.password = "123456"
        loginViewModel.validate()
        
        XCTAssertTrue(loginViewModel.isValid)
    }
    
}
