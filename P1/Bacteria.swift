//
//  Bacteria.swift
//  P1
//
//  Created by Cao Viet Huy on 20/12/2023.
//

import SwiftUI

class Bacteria {
    enum Direction: CaseIterable {
        case north, south, west, esat
        
        var rotation : Double {
            switch self {
            case .north: return 0
            case .south: return 180
            case .esat: return 90
            case .west: return 270
            }
        }
        
        var opposite : Direction {
            switch self {
            case .north: return .south
            case .south: return .north
            case .esat: return .west
            case .west: return .esat
            }
        }
        
        var next : Direction {
            switch self {
            case .north: return .esat
            case .south: return .west
            case .esat: return .south
            case .west: return .north
            }
        }
    }
    
    var row: Int
    var col : Int
    
    var color = Color.gray
    var direction = Direction.north
    
    
    init (row: Int, col: Int) {
        self.row = row
        self.col = col
    }
    
}
