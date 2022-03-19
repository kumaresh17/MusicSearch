//
//  MusicSearchUITests.swift
//  MusicSearchUITests
//
//  Created by kumaresh shrivastava on 16/03/2022.
//

import XCTest

class MusicHome_Detail_NavigationUITests: XCTestCase {

    func test_navigation_title_searchfield_track_artist_album_buttons_exits() {
        
        let app = XCUIApplication()
        app.launch()
        
        let navTitle = app.navigationBars["Music search"].staticTexts["Music search"]
        let searchField = app.searchFields["Search by album | track | artist "]

        
        XCTAssertTrue(navTitle.exists)
        XCTAssertTrue(searchField.exists)
        

        let trackSegment = app/*@START_MENU_TOKEN@*/.buttons["Track"]/*[[".segmentedControls[\"scopeBar\"].buttons[\"Track\"]",".buttons[\"Track\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let artistSegment = app/*@START_MENU_TOKEN@*/.buttons["Artist"]/*[[".segmentedControls[\"scopeBar\"].buttons[\"Artist\"]",".buttons[\"Artist\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let albumSegment = app/*@START_MENU_TOKEN@*/.buttons["Album"]/*[[".segmentedControls[\"scopeBar\"].buttons[\"Album\"]",".buttons[\"Album\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        XCTAssertTrue(trackSegment.exists)
        XCTAssertTrue(artistSegment.exists)
        XCTAssertTrue(albumSegment.exists)
    }
    
    /**
     Important note to test :- Simulator -> I/O - > Keyboard -> unselect connect to hardware keyboard to perform below UI test, else test will crash as it won't br able to find the physical keyboard KEYS.
     */
    func test_music_screen_search_and_activity_indicator_shows_hide_on_api_result_and_navigated_to_detail_screen_back() {
        
        let app = XCUIApplication()
        app.launch()
        
        let activityIndicator = app.activityIndicators["In progress"]
        
        let expect = expectation(description: "API response completion")
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
        
        XCTAssertTrue(activityIndicator.exists)
        
        expect.fulfill()
        
        let tableCell =  app.tables/*@START_MENU_TOKEN@*/.staticTexts["Sound Of Silver"]/*[[".cells.staticTexts[\"Sound Of Silver\"]",".staticTexts[\"Sound Of Silver\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        tableCell.tap()
        
        waitForExpectations(timeout: 15, handler: nil)
        
        XCTAssertFalse(activityIndicator.exists)
        
        let musicDetailsNavigationBar = app.navigationBars["Music details"]
        XCTAssertTrue(musicDetailsNavigationBar.exists)
        let title = app.staticTexts["Sound Of Silver"]
        XCTAssertTrue(title.exists)
        let name =  app.staticTexts["LCD Soundsystem"]
        XCTAssertTrue(name.exists)
        //back
        musicDetailsNavigationBar.buttons["Music search"].tap()
        // serach field visible
        XCTAssertTrue(searchByAlbumTrackArtistSearchField.exists)
        
    }
}
