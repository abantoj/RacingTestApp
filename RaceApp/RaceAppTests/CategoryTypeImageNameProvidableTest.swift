//
//  CategoryTypeImageNameProvidableTest.swift
//  RaceAppTests
//
//  Created by James Abanto on 17/7/2024.
//

import XCTest
@testable import RaceApp

final class CategoryTypeImageNameProvidableTest: XCTestCase {
    
    func testGetImageName_whenCategoryTypeHarness_returnCorrectly() {
        let mockProvider = MockCategoryTypeImageNameProvidable()
        let imageName = mockProvider.getImageName(forCategory: .harnessRacing)
        XCTAssertEqual(imageName, "harness")
    }
    
    func testGetImageName_whenCategoryTypeGreyhound_returnCorrectly() {
        let mockProvider = MockCategoryTypeImageNameProvidable()
        let imageName = mockProvider.getImageName(forCategory: .greyhoundRacing)
        XCTAssertEqual(imageName, "greyhound")
    }
    
    func testGetImageName_whenCategoryTypeHorse_returnCorrectly() {
        let mockProvider = MockCategoryTypeImageNameProvidable()
        let imageName = mockProvider.getImageName(forCategory: .horseRacing)
        XCTAssertEqual(imageName, "horse")
    }
}

private struct MockCategoryTypeImageNameProvidable: CategoryTypeImageNameProvidable { }
