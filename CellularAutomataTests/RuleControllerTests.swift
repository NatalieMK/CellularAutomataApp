//
//  RuleControllerTests.swift
//  CellularAutomataTests
//
//  Created by Natalie on 1/15/22.
//

import XCTest
@testable import CellularAutomata

class RuleControllerTests: XCTestCase {
    
    var pattern: Pattern!
    var ruleControl: RuleController!

    override func setUp() {
        super.setUp()
        pattern = Pattern(cells: [Cell(), Cell(), Cell()])
        ruleControl = RuleController()
    }

    override func tearDown(){
        super.tearDown()
        pattern = nil
        ruleControl = nil
    }
    
    func testMarkAtIndex(){
        pattern = ruleControl.markPatternAtIndex(pattern: pattern, markedIndex: 1)
        XCTAssert(pattern.cells[1].currentCellState)
    }
    
    func testUpdateByNumberOfStates(){
        pattern = ruleControl.markPatternAtIndex(pattern: pattern, markedIndex: 1)
        pattern.padPattern(count: 9)
        pattern = ruleControl.updateByNumberOfStates(count: 9, pattern: pattern, rule: ruleControl.rule30(cell:))
        XCTAssertEqual(pattern.patternAsString(), "011011110110010001110")
    }
    
    func testRule110(){
        pattern = ruleControl.markPatternAtIndex(pattern: pattern, markedIndex: 1)
        pattern.padPattern(count: 9)
        pattern = ruleControl.updateByNumberOfStates(count: 9, pattern: pattern, rule: ruleControl.rule110(cell:))
        XCTAssertEqual(pattern.patternAsString(), "011000001110000000000")
    }
    
    func testRule90(){
        pattern = ruleControl.markPatternAtIndex(pattern: pattern, markedIndex: 1)
        pattern.padPattern(count: 9)
        pattern = ruleControl.updateByNumberOfStates(count: 9, pattern: pattern, rule: ruleControl.rule90(cell:))
        XCTAssertEqual(pattern.patternAsString(), "010100000000000001010")
    }

    func testHighNumberRule30Performance() {
        pattern = ruleControl.markPatternAtIndex(pattern: pattern, markedIndex: 1)
        pattern.padPattern(count: 99)
        self.measure {
            pattern = ruleControl.updateByNumberOfStates(count: 99, pattern: pattern, rule: ruleControl.rule30(cell:))
        }
    }
    
    func testHighNumberRule90Performance() {
        pattern = ruleControl.markPatternAtIndex(pattern: pattern, markedIndex: 1)
        pattern.padPattern(count: 99)
        self.measure {
            pattern = ruleControl.updateByNumberOfStates(count: 99, pattern: pattern, rule: ruleControl.rule90(cell:))
        }
    }

}
