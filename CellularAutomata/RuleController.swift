//
//  RuleController.swift
//  CellularAutomata
//
//  Created by Natalie on 1/12/22.
//

import Foundation

public class RuleController {
    
    var pattern = Pattern()
    
    func advanceByNumberOfStates(count: Int, pattern: Pattern) -> Pattern{
        var pat = pattern

        for i in 0...count {
            pat.advancePattern()
        }
        return pat
    }
    
    func markPattern(pattern: Pattern, markedIndex: Int) -> Pattern {
        var pat = pattern
        pat.cells[markedIndex] = Cell(leftCellState: false, rightCellState: false, currentCellState: true, upcomingCellState: nil)
        return pat
    }
    
    func padPattern(pattern: Pattern, count: Int) -> Pattern {
        var pat = Pattern()
        while pat.cells.count < (count * 2 + 3) {
            pat.cells.append(Cell())
            pat.cells.insert(Cell(), at: 0)
        }
        return pat
    }
    
}
