//
//  AuthenticationViewModelTest.swift
//  InstagramCloneTests
//
//  Created by nandawperdana on 05/08/24.
//

import XCTest
@testable import InstagramClone

final class AuthenticationViewModelTest: XCTestCase {
    func testLoginViewModel_isValidForm() {
        // Given When
        let viewModel = LoginViewModel(email: "test@test.com", password: "password")
        
        // Then
        XCTAssertTrue(viewModel.isValidForm)
        XCTAssertEqual(viewModel.buttonBackgroundColor, UIColor.systemBlue)
    }
    
    func testLoginViewModel_isInvalidForm() {
        // Given When
        let viewModel = LoginViewModel(email: "", password: "password")
        
        // Then
        XCTAssertFalse(viewModel.isValidForm)
        XCTAssertEqual(viewModel.buttonBackgroundColor, UIColor.systemBlue.withAlphaComponent(0.5))
    }
}
