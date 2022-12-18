////
////  PlaceServiceTest.swift
////  ChangingBabyTests
////
////  Created by Yves Charpentier on 16/11/2022.
////
//
//import XCTest
//@testable import ChangingBaby
//
//final class PlaceServiceTest: XCTestCase {
//    
//    func testGivenDataTestWhenFetchPlaceThenFetchIsOK() {
//        // Given
//        let placeTestName: String = "Pizza Papa"
//        let placeTestZip: Int = 34000
//        // When
//        placeService.fetchPlaces(collectionID: "places") { place in
//            XCTAssertEqual(place[0].name, placeTestName)
//            XCTAssertEqual(place[0].zip, placeTestZip)
//        }
//        // Then
//    }
//    
//    func testGivenDataTestWhenFetchPlaceThenFetchIsKO() {
//        // Given
//        let placeTestName: String = "Test"
//        let placeTestZip: Int = 75000
//        // When
//        placeService.fetchPlaces(collectionID: "places") { place in
//            XCTAssertNotEqual(place[0].name, placeTestName)
//            XCTAssertNotEqual(place[0].zip, placeTestZip)
//        }
//        // Then
//    }
//}
