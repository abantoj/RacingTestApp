//
//  CountDownTextFormattableTest.swift
//  RaceAppTests
//
//  Created by James Abanto on 17/7/2024.
//

import XCTest
@testable import RaceApp

final class CountDownTextFormattableTest: XCTestCase {

    func testCountDownText_whenMoreThan5Minutes_returnResultOnlyMinutes() {
        let mockFormatter = MockCountDownTextFormatter()
        let result = mockFormatter.formatCountdownTime(timeRemaining: 600)
        XCTAssertEqual(result, "10m")
    }
    
    func testCountDownText_whenLessThan5Minutes_returnResultMinutesAndSeconds() {
        let mockFormatter = MockCountDownTextFormatter()
        let result = mockFormatter.formatCountdownTime(timeRemaining: 299)
        XCTAssertEqual(result, "4m 59s")
    }
    
    func testCountDownText_whenLessThanAMinute_returnResultOnlySeconds() {
        let mockFormatter = MockCountDownTextFormatter()
        let result = mockFormatter.formatCountdownTime(timeRemaining: 59)
        XCTAssertEqual(result, "59s")
    }
}

private struct MockCountDownTextFormatter: CountDownTextFormattable { }
