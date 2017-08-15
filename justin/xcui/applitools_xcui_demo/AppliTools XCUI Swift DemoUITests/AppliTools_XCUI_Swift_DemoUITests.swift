//
//  AppliTools_XCUI_Swift_DemoUITests.swift
//  AppliTools XCUI Swift DemoUITests
//
//  Created by Anton Chuev on 4/5/17.
//  Copyright © 2017 appli-tools. All rights reserved.
//

import XCTest

class AppliTools_XCUI_Swift_DemoUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let application = XCUIApplication();
        application.buttons["show elements"].tap();
        
        let eyes = XCUIEyes();
        eyes.apiKey = "gmyiCQ7GFUPMiMTFWh5FgqCdIOR5BL7l78LAmBw6sgc110";
        
        eyes.openX
        
        eyes.open(withApplicationName: "2", testName: "3")
        
        eyes.open(withApplicationName: "1", testName: "2")
        
        
//        eyes.open(withApplicationName: "1", testName: "2")
        
//        eyes.open(withApplicationName: "Demo app", testName: "XCUI full page screenshot #13");
        
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
