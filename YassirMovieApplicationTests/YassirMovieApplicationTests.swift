//
//  YassirMovieApplicationTests.swift
//  YassirMovieApplicationTests
//
//  Created by MacBook AIR on 24/06/2024.
//

import XCTest

@testable import YassirMovieApplication

final class APiManagerTest: XCTestCase {

    
    func test_valuesKeys() {
        
        let TestAuthorizationKey = Constants.AuthorizationToken
        let TestApiKeY =  Constants.Api_key
        let TestGoogleKey = Constants.google
        
        XCTAssertEqual(TestAuthorizationKey, "AIzaSyD0nXdMQDmVE-Jl8_FSwbhlo8UGD7eUvHU")
        XCTAssertEqual(TestGoogleKey, "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwZjgwMDI5MTMyYzJhYWFhNjVjNTU1ZDg4ZDk5Zjc0ZSIsIm5iZiI6MTcxOTA4NzA2My42NzAwMjksInN1YiI6IjY2NzcyZWQ0NTJlOGQ1MDk5MTVlNzBiMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GqDlNVeG1TpJRdDNx6jDIlDwo0uHOi05_fUdJ5nEvHU")
        XCTAssertEqual(TestApiKeY, "30bbc9465ce5edc1448ae2367d7727b7")
    }

}
