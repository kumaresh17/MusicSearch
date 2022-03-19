//
//  PerformanceTests.swift
//  MusicSearchUITests
//
//  Created by kumaresh shrivastava on 18/03/2022.
//

import XCTest

class PerformanceTests: XCTestCase {

    // test_music_detail_performance_memory_measure
    
    /**
           Important note to test :- Simulator -> I/O - > Keyboard -> unselect connect to hardware keyboard to perform below UI test, else test will crash as it won't br able to find the physical keyboard KEYS.
     */
    func test_music_detail_performance_memory_measure() {
        let app = XCUIApplication()
    
        let options = XCTMeasureOptions()
        options.invocationOptions = [.manuallyStart]
        measure(metrics: [XCTMemoryMetric(application:app)], options: options) {
            app.launch()
            startMeasuring()
        
            let searchByAlbumTrackArtistSearchField = app.searchFields["Search by album | track | artist "]
            searchByAlbumTrackArtistSearchField.tap()
            
            let sKey = app/*@START_MENU_TOKEN@*/.keys["S"]/*[[".keyboards.keys[\"S\"]",".keys[\"S\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
            sKey.tap()
            
            
            let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
            oKey.tap()
            
            
            let nKey = app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
            nKey.tap()
            
            
            let uKey = app/*@START_MENU_TOKEN@*/.keys["u"]/*[[".keyboards.keys[\"u\"]",".keys[\"u\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
            uKey.tap()
            
            app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"search\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
            
            let tableCell =  app.tables/*@START_MENU_TOKEN@*/.staticTexts["Sound Of Silver"]/*[[".cells.staticTexts[\"Sound Of Silver\"]",".staticTexts[\"Sound Of Silver\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
            tableCell.tap()

            let musicDetailsNavigationBar = app.navigationBars["Music details"]
            
            //back
            musicDetailsNavigationBar.buttons["Music search"].tap()
            // serach field visible
            XCTAssertTrue(searchByAlbumTrackArtistSearchField.waitForExistence(timeout: 1))
        }
    }

}
