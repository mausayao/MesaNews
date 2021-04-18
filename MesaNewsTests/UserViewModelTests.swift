//
//  UserViewModelTests.swift
//  MesaNewsTests
//
//  Created by Maurício de Freitas Sayão on 18/04/21.
//


import XCTest
@testable import MesaNews

final class UserViewModelTests: XCTestCase {
    
    var userViewModel: UserViewModel!
    
    override func setUp() {
        super.setUp()
        userViewModel = UserViewModel(user: .init(name: "", email: "", password: ""))
    }
    
    
    func testUserIsValid() {
       
        userViewModel.name = "João da Silva"
        userViewModel.email = "joão@silva.com"
        userViewModel.password = "xxxxxx"
        userViewModel.validate()
        
        XCTAssertTrue(userViewModel.isValid)
    }
    
    
}

