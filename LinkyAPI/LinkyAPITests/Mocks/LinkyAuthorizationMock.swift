//
//  LinkyAuthorizationMock.swift
//  LinkyAPITests
//
//  Created by Karim Angama on 22/06/2023.
//

import Foundation
@testable import LinkyAPI

class LinkyAuthorizationMock: LinkyAuthorization {
    
    var isDisplayWebViewScreenIsCalled = false
    var isDismissScreenIsCalled = false
    var isHandleAccessToken = false
    var isSuperHandleAccessToken = false
    
    override func displayWebViewScreen() {
        isDisplayWebViewScreenIsCalled = true
    }
    
    override func dismissScreen() {
        isDismissScreenIsCalled = true
    }
    
    override func handleAccessToken() {
        if isSuperHandleAccessToken {
            super.handleAccessToken()
        }
        isHandleAccessToken = true
    }
    
}
