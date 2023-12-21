//
//  GameBoard.swift
//  P1
//
//  Created by Cao Viet Huy on 20/12/2023.
//

import SwiftUI

class GameBoard: ObservableObject {
    let rowCount = 11
    let columnCount = 21
    
    @Published var grid = [[Bacteria]]()
    
    @Published var currentPlayer = Color.green
    @Published var greenScore = 1
    @Published var redScore = 1
    
    @Published var winner : String? = nil
    
    var bacteriaToBeInfected = 0
    
    init() {
        reset()
    }
    
    func reset() {
        winner = nil
        currentPlayer = Color.green
        greenScore = 1
        redScore = 1
        
        grid.removeAll()
        
        
        for row in 0..<rowCount {
            var newRow = [Bacteria]()
            
            for col in 0..<columnCount {
                let bacteria = Bacteria(row: row, col: col)
                
                // Make sure the player can start perfectly
                if row <= rowCount / 2 {
                    if row == 0 && col == 0 {
                        bacteria.direction = .north
                    } else if row == 0 && col == 1 {
                        bacteria.direction = .esat
                    } else if row == 1 && col == 0 {
                        bacteria.direction = .south
                    } else {
                        bacteria.direction = Bacteria.Direction.allCases.randomElement()!
                    }
                } else {
                    if let counterPart = getBacteria(atRow: rowCount - row - 1, col: columnCount - col - 1) {
                        bacteria.direction = counterPart.direction.opposite
                    }
                }
                
                newRow.append(bacteria)
            }
            
            grid.append(newRow)
        }
        
        grid[0][0].color = .green
        grid[rowCount - 1][columnCount - 1].color = .red
    }
    
    func getBacteria(atRow row: Int, col: Int) -> Bacteria? {
        guard row >= 0 && row < rowCount else {return nil}
        guard col >= 0 && col < columnCount else {return nil}
        return grid[row][col]
    }
    
    func infect(from: Bacteria) {
        objectWillChange.send()
        
        var bacteriaToInfect = [Bacteria?]()
        
        switch from.direction {
        case .north:
            bacteriaToInfect.append(getBacteria(atRow: from.row - 1, col: from.col))
        case .south:
            bacteriaToInfect.append(getBacteria(atRow: from.row + 1, col: from.col))
        case .esat:
            bacteriaToInfect.append(getBacteria(atRow: from.row, col: from.col + 1))
        case .west:
            bacteriaToInfect.append(getBacteria(atRow: from.row, col: from.col - 1))
        }
        
        if let indirect = getBacteria(atRow: from.row - 1, col: from.col) {
            if indirect.direction == .south {
                bacteriaToInfect.append(indirect)
            }
        }
        
        if let indirect = getBacteria(atRow: from.row + 1, col: from.col) {
            if indirect.direction == .north {
                bacteriaToInfect.append(indirect)
            }
        }
        
        if let indirect = getBacteria(atRow: from.row , col: from.col - 1) {
            if indirect.direction == .esat {
                bacteriaToInfect.append(indirect)
            }
        }
        
        if let indirect = getBacteria(atRow: from.row, col: from.col + 1) {
            if indirect.direction == .west {
                bacteriaToInfect.append(indirect)
            }
        }
        
        for case let bacteria? in bacteriaToInfect {
            if bacteria.color != from.color {
                bacteria.color = from.color
                bacteriaToBeInfected += 1
                
                Task { @MainActor in
                    try await Task.sleep(nanoseconds: 50_000_000)
                    
                    bacteriaToBeInfected -= 1
                    infect(from: bacteria)
                }
            }
        }
        
        updateScores()
    }
    
    func rotate(bacteria : Bacteria) {
        guard bacteria.color == currentPlayer else {return}
        guard bacteriaToBeInfected == 0 else {return}
        
        objectWillChange.send()
        
        bacteria.direction = bacteria.direction.next
        
        infect(from: bacteria)
    }
    
    func changePlayer() {
        if currentPlayer == .red {
            currentPlayer = .green
        }else {
            currentPlayer = .red
        }
    }
    
    func updateScores() {
        var newRedScore = 0
        var newGreenScore = 0
        
        for row in grid {
            for bacteria in row {
                if bacteria.color == .red {
                    newRedScore += 1
                }else if bacteria.color == .green {
                    newGreenScore += 1
                }
            }
        }
        
        redScore = newRedScore
        greenScore = newGreenScore
        
        
        if bacteriaToBeInfected == 0 {
            withAnimation(.spring()) {
                if redScore == 0 {
                    winner = "Green"
                }else if greenScore == 0 {
                    winner = "Red"
                }else {
                    changePlayer()
                }
            }
        }
    }
    
}

