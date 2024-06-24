//
//  YassirMovieApplicationTests.swift
//  YassirMovieApplicationTests
//
//  Created by MacBook AIR on 24/06/2024.
//

import XCTest
@testable import YassirMovieApplication

final class YassirMovieApplicationTests: XCTestCase {

    
    func test_apiValuesKeys_ifIsEqualToMainKeys() {
        
        let TestAuthorizationKey = Constants.AuthorizationToken
        let TestApiKeY =  Constants.Api_key
        let TestGoogleKey = Constants.google
        
        let MainTestAuthorizationKey = "AIzaSyD0nXdMQDmVE-Jl8_FSwbhlo8UGD7eUvHU"
        let MainTestGoogleKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwZjgwMDI5MTMyYzJhYWFhNjVjNTU1ZDg4ZDk5Zjc0ZSIsIm5iZiI6MTcxOTA4NzA2My42NzAwMjksInN1YiI6IjY2NzcyZWQ0NTJlOGQ1MDk5MTVlNzBiMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GqDlNVeG1TpJRdDNx6jDIlDwo0uHOi05_fUdJ5nEvHU"
        let MainTestApiKeY =  "30bbc9465ce5edc1448ae2367d7727b7"
        
        XCTAssertEqual(TestAuthorizationKey,MainTestAuthorizationKey)
        XCTAssertEqual(TestGoogleKey,MainTestGoogleKey )
        XCTAssertEqual(TestApiKeY, MainTestApiKeY)
    }
 
    func test_APiValueKeys_ifIsNotEquelToMainKeys() {
        let TestAuthorizationKey = Constants.AuthorizationToken
        let TestApiKeY =  Constants.Api_key
        let TestGoogleKey = Constants.google
        
        let MainTestAuthorizationKey = "AIzaSyD0nXdMQDmVE-Jl8_FSwbhlo8UG"
        let MainTestGoogleKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwZjgwMDI5MTMyYzJhYWFhNjVjNTU1ZDg4ZDk5Zjc0ZSIsIm5iZiI6MTcxOTA4NzA2My42NzAwMjksInN1YiI6IjY2NzcyZWQ0NTJlOGQ1MDk5MTVlNzBiMSIsInNjb3BlcyI6WyJhcGlfcmVhZCQ.GqDlNVeG1TpJRdDNx6jDIlDwo0uHOi05_fUdJ5nEvHU"
        let MainTestApiKeY =  "30bbc9465ce5edc1448ae2367d77"
        
        XCTAssertNotEqual(TestAuthorizationKey,MainTestAuthorizationKey )
        XCTAssertNotEqual(TestGoogleKey,MainTestGoogleKey)
        XCTAssertNotEqual(TestApiKeY, MainTestApiKeY)
        
    }

}
