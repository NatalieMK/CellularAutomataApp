//
//  CellStateModel.swift
//  CellularAutomata
//
//  Created by Natalie on 1/12/22.
//

import Foundation

struct Rules {
    func rule30(cell: Cell) -> Bool{
        let state = cell.leftCellState.intValue ^ (cell.currentCellState || cell.rightCellState).intValue
        return (state != 0)
    }
}

struct Cell {
    // Default 0 cell
    var leftCellState: Bool = false
    var rightCellState: Bool = false
    var currentCellState: Bool = false
    var upcomingCellState: Bool? = nil
    
    func getUpcomingCellState() -> Bool{
        let state = leftCellState.intValue ^ (currentCellState || rightCellState).intValue
        return (state != 0)
    }
}

struct Pattern {
    var cells: [Cell] = [Cell()]
    
    // Pattern will be started from single 0 cell

    mutating func determinePattern(){
        
        // Added "empty cell" padding on each end of the cell array. This allows the pattern to continue indefinitely without risk of index out of bounds
        
        cells.insert(Cell(leftCellState: false, rightCellState: false, currentCellState: false, upcomingCellState: false), at: 0)
        
        cells.append(Cell(leftCellState: false, rightCellState: false, currentCellState: false, upcomingCellState: false))
        
        // Index of the last non-padding cell
        let lastSignificantDigit = cells.count - 2
        
        
        for index in 1...lastSignificantDigit{
            cells[index].leftCellState = cells[index - 1].currentCellState
            cells[index].rightCellState = cells[index + 1].currentCellState
            cells[index].upcomingCellState = cells[index].getUpcomingCellState()
        }
        
        // Remove padding cells
        cells.remove(at: 0)
        cells.removeLast()
    }
    
    // Return binary String representation of the current pattern array.
    func patternAsString() -> String {
        var returnString = ""
        for cell in cells {
            returnString.append("\(cell.currentCellState.intValue)")
        }
        return returnString
    }
    
    // Advance pattern, all cells updated to their next cell state
    mutating func advancePattern(){
        determinePattern()
        for i in 0..<cells.count{
            cells[i].currentCellState = cells[i].upcomingCellState ?? cells[i].currentCellState
        }
    }
    
}
