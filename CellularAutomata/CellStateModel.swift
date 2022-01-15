//
//  CellStateModel.swift
//  CellularAutomata
//
//  Created by Natalie on 1/12/22.
//

import Foundation

struct Cell {
    // Default 0 cell
    var leftCellState: Bool = false
    var rightCellState: Bool = false
    var currentCellState: Bool = false
    var upcomingCellState: Bool? = nil
    
    // Determine cells upcoming state conforming to rule
    func determineUpcomingCellState(rule: (Cell) -> Bool) -> Bool{
        return rule(self)
    }
    
    // Update cell state to upcoming state
    mutating func updateCell() {
        currentCellState = upcomingCellState ?? currentCellState
    }
}

struct Pattern {
    var cells: [Cell] = [Cell()]
    
    // Add empty cells to each side of array. Helpful for keeping a consistent array count.
    mutating func padPattern(count: Int){
        while cells.count < (count * 2 + 3) {
            cells.append(Cell())
            cells.insert(Cell(), at: 0)
        }
    }
    
    // Return binary String representation of the current pattern array.
    func patternAsString() -> String {
        var returnString = ""
        for cell in cells {
            returnString.append("\(cell.currentCellState.intValue)")
        }
        return returnString
    }
    
    // updatePattern without changing total number of cells, useful when pattern is already padded
    mutating func updatePattern(rule: (Cell) -> Bool){
        cells.insert(Cell(leftCellState: false, rightCellState: false, currentCellState: false, upcomingCellState: false), at: 0)
        cells.append(Cell(leftCellState: false, rightCellState: false, currentCellState: false, upcomingCellState: false))
        let lastSignificantDigit = cells.count - 2
        for index in 1...lastSignificantDigit{
            cells[index].leftCellState = cells[index - 1].currentCellState
            cells[index].rightCellState = cells[index + 1].currentCellState
            cells[index].upcomingCellState = cells[index].determineUpcomingCellState(rule: rule)
        }
        for i in 0..<cells.count{
            cells[i].updateCell()
        }
        //Remove padding cells
        cells.remove(at: 0)
        cells.removeLast()
    }
    
    // Advance pattern, all cells updated to their next cell state
    // Advances pattern in a step-wise function, without need for initial padding
    mutating func advancePattern(rule: (Cell) -> Bool){
        cells.insert(Cell(leftCellState: false, rightCellState: false, currentCellState: false, upcomingCellState: false), at: 0)
        cells.append(Cell(leftCellState: false, rightCellState: false, currentCellState: false, upcomingCellState: false))
        let lastSignificantDigit = cells.count - 2
        for index in 1...lastSignificantDigit{
            cells[index].leftCellState = cells[index - 1].currentCellState
            cells[index].rightCellState = cells[index + 1].currentCellState
            cells[index].upcomingCellState = cells[index].determineUpcomingCellState(rule: rule)
        }
        for i in 0..<cells.count{
            cells[i].currentCellState = cells[i].upcomingCellState ?? cells[i].currentCellState
        }
    }
    
    // Included for easier unit testing
    func rule30(cell: Cell) -> Bool{
        let state = cell.leftCellState.intValue ^ (cell.currentCellState || cell.rightCellState).intValue
        return (state != 0)
    }

}
