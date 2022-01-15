//
//  RuleController.swift
//  CellularAutomata
//
//  Created by Natalie on 1/12/22.
//

import Foundation
import UIKit

public class RuleController {
    
    var pattern = Pattern()
    
    // Rule functions
    func rule30(cell: Cell) -> Bool{
        let state = cell.leftCellState.intValue ^ (cell.currentCellState || cell.rightCellState).intValue
        return (state != 0)
    }
    
    // Update pattern count number of times according to entered rule
    func updateByNumberOfStates(count: Int, pattern: Pattern, rule: (Cell) -> Bool) -> Pattern{
        var pat = pattern
        for _ in 0...count {
            pat.updatePattern(rule: rule)
        }
        return pat
    }
    
    // Choose cell to "mark" positive at index
    func markPatternAtIndex(pattern: Pattern, markedIndex: Int) -> Pattern {
        var pat = pattern
        pat.cells[markedIndex] = Cell(leftCellState: false, rightCellState: false, currentCellState: true, upcomingCellState: nil)
        return pat
    }
    
}
