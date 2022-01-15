//
//  CellStateModelTests.swift
//  CellularAutomataTests
//
//  Created by Natalie on 1/12/22.
//

import XCTest
@testable import CellularAutomata

class CellStateModelTests: XCTestCase {

    var pattern: Pattern!
    
    override func setUp() {
        super.setUp()
        pattern = Pattern()
    }
    
    override func tearDown() {
        super.tearDown()
        pattern = nil
    }
    
    // Make sure formatting is correct when first creating pattern with no input
    func testPatternInit(){
        XCTAssertEqual(pattern.patternAsString(), "0")
    }
    func testAdvancePattern(){
        pattern.advancePattern(rule: pattern.rule30(cell:))
        XCTAssertEqual(pattern.patternAsString(), "000")
    }
    
    func testPatternInitWithInput(){
        pattern = Pattern(cells: [Cell(leftCellState: false, rightCellState: false, currentCellState: true, upcomingCellState: nil)])
        XCTAssert(pattern.cells[0].currentCellState)
    }
    func testExistingPatternAddCell(){
        pattern.cells = [Cell(leftCellState: false, rightCellState: false, currentCellState: true, upcomingCellState: nil)]
        XCTAssert(pattern.cells[0].currentCellState)
    }
    
    
    // Testing larger numbers of iteration with known constants
    func testAdvancePatternByTenTimes(){
        pattern.cells = [Cell(leftCellState: false, rightCellState: false, currentCellState: true, upcomingCellState: nil)]
        pattern.advancePattern(rule: pattern.rule30(cell:)) // 010
        pattern.advancePattern(rule: pattern.rule30(cell:)) // 01110
        pattern.advancePattern(rule: pattern.rule30(cell:)) // 0110010
        pattern.advancePattern(rule: pattern.rule30(cell:)) // 011011110
        pattern.advancePattern(rule: pattern.rule30(cell:)) // 01100100010
        pattern.advancePattern(rule: pattern.rule30(cell:)) // 0110111101110
        pattern.advancePattern(rule: pattern.rule30(cell:)) // 011001000010010
        pattern.advancePattern(rule: pattern.rule30(cell:)) // 01101111001111110
        pattern.advancePattern(rule: pattern.rule30(cell:)) // 0110010001110000010
        pattern.advancePattern(rule: pattern.rule30(cell:)) // 011011110110010001110
        XCTAssertEqual(pattern.patternAsString(), "011011110110010001110")
    }
    
    func testAdvancePatternByFiftyTimes(){
        pattern.cells = [Cell(leftCellState: false, rightCellState: false, currentCellState: true, upcomingCellState: nil)]
        for i in 0...50 {
            pattern.advancePattern(rule: pattern.rule30(cell:))
        }
        XCTAssertEqual(pattern.patternAsString(), "0110010000101110010110101001100101000011000010001100100010101100000000110001101110111000010101100110010")
    }
    
    

    func testExample() throws {
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
