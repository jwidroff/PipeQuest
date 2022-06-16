//
//  Piece.swift
//  PipeLord
//
//  Created by Jeffery Widroff on 06/04/2022.
//

import Foundation
import UIKit


class Piece {
    
    var indexes = Indexes()
    var shape: Shape = .blank
    var view = ShapeView()
    var colors = [UIColor()]
    var side = Side()
    var version = Int()
    var isLocked = false
    var nextPiece: Piece?
    var doesPivot = false
    var center = CGPoint()
    var totalVersions = Int()
    
    init(){
        
    }
    
    init(indexes: Indexes, shape: Shape, colors: [UIColor], version: Int, isLocked: Bool, doesPivot: Bool) {
        
        self.indexes = indexes
        self.shape = shape
        self.colors = colors
        self.version = version
//        self.currentSwitch = currentSwitch
        self.isLocked = isLocked
        
//        if let doesPivot = doesPivot {
            self.doesPivot = doesPivot
//        }
        
//        if let opening = opening {
//            self.opening = opening
//        }
        
        if colors.count == 1 {
            
            self.colors.append(colors[0])
        }
        
//        setPieceSwitches() //MARK: NOT USED
        
        setPieceTotalVersions(shape: shape)
        setPieceSides(shape: shape, version: version, colors: self.colors)
    }
    
    
    func setPieceTotalVersions(shape: Shape) {
        
        
        switch shape {
            
            
        case .doubleElbow:
            totalVersions = 8
            
        case .stick:
            totalVersions = 4
            
        case .elbow:
            totalVersions = 4
            
        case .cross:
            totalVersions = 4
            
        case .diagElbow:
            totalVersions = 4
            
        case .entrance:
            totalVersions = 4
            
        case .exit:
            totalVersions = 4
            
        case .pieceMaker:
            totalVersions = 4
            
        default:
            
            break
            
        }
        
    }
    
    func setPieceSides(shape: Shape, version: Int, colors: [UIColor]) {
        
        switch shape {
            
        case .blank:
            
            side.left.color = nil
            side.right.color = nil
            side.top.color = nil
            side.bottom.color = nil
            
            side.left.exitSide = nil
            side.right.exitSide = nil
            side.top.exitSide = nil
            side.bottom.exitSide = nil
            
            side.left.opening.isOpen = false
            side.right.opening.isOpen = false
            side.top.opening.isOpen = false
            side.bottom.opening.isOpen = false
            
        case .stick:
            
            switch version {
            case 1:
                
                side.left.color = colors[0]
                side.right.color = colors[1]
                side.top.color = nil
                side.bottom.color = nil
                
                side.left.exitSide = "right"
                side.right.exitSide = "left"
                side.top.exitSide = nil
                side.bottom.exitSide = nil
                
                side.left.opening.isOpen = true
                side.right.opening.isOpen = true
                side.top.opening.isOpen = false
                side.bottom.opening.isOpen = false

            case 2:
                    
                side.top.color = colors[0]
                side.bottom.color = colors[1]
                side.left.color = nil
                side.right.color = nil
                
                side.top.exitSide = "bottom"
                side.bottom.exitSide = "top"
                side.left.exitSide = nil
                side.right.exitSide = nil
                
                side.top.opening.isOpen = true
                side.bottom.opening.isOpen = true
                side.left.opening.isOpen = false
                side.right.opening.isOpen = false
                    
            case 3:
                
                side.left.color = colors[1]
                side.right.color = colors[0]
                side.top.color = nil
                side.bottom.color = nil
                
                side.left.exitSide = "right"
                side.right.exitSide = "left"
                side.top.exitSide = nil
                side.bottom.exitSide = nil
                
                side.left.opening.isOpen = true
                side.right.opening.isOpen = true
                side.top.opening.isOpen = false
                side.bottom.opening.isOpen = false
                
            case 4:
                
                side.top.color = colors[1]
                side.bottom.color = colors[0]
                side.left.color = nil
                side.right.color = nil
                
                side.top.exitSide = "bottom"
                side.bottom.exitSide = "top"
                side.left.exitSide = nil
                side.right.exitSide = nil
                
                side.top.opening.isOpen = true
                side.bottom.opening.isOpen = true
                side.left.opening.isOpen = false
                side.right.opening.isOpen = false
                
            default:
                break
            }
            
        case .entrance:
            
            switch version {
            
            case 1:
                
                side.top.color = colors[0]
                side.left.color = nil
                side.bottom.color = nil
                side.right.color = nil
                
                side.top.exitSide = "center"
                side.left.exitSide = nil
                side.bottom.exitSide = nil
                side.right.exitSide = nil
                
                side.top.opening.isOpen = true
                side.left.opening.isOpen = false
                side.bottom.opening.isOpen = false
                side.right.opening.isOpen = false

            case 2:
                
                side.right.color = colors[0]
                side.left.color = nil
                side.bottom.color = nil
                side.top.color = nil
                
                side.right.exitSide = "center"
                side.left.exitSide = nil
                side.bottom.exitSide = nil
                side.top.exitSide = nil
                
                side.right.opening.isOpen = true
                side.left.opening.isOpen = false
                side.bottom.opening.isOpen = false
                side.top.opening.isOpen = false
               
            case 3:
                
                side.bottom.color = colors[0]
                side.left.color = nil
                side.top.color = nil
                side.right.color = nil
                
                side.bottom.exitSide = "center"
                side.left.exitSide = nil
                side.top.exitSide = nil
                side.right.exitSide = nil
                
                side.bottom.opening.isOpen = true
                side.left.opening.isOpen = false
                side.top.opening.isOpen = false
                side.right.opening.isOpen = false

            case 4:
                
                side.left.color = colors[0]
                side.top.color = nil
                side.bottom.color = nil
                side.right.color = nil
                
                side.left.exitSide = "center"
                side.top.exitSide = nil
                side.bottom.exitSide = nil
                side.right.exitSide = nil
                
                side.left.opening.isOpen = true
                side.top.opening.isOpen = false
                side.bottom.opening.isOpen = false
                side.right.opening.isOpen = false

            default:
                break
            }
        
        case .exit:
            
            switch version {
            
            case 1:
                
                side.top.color = colors[0]
                side.left.color = nil
                side.bottom.color = nil
                side.right.color = nil
                
                side.top.exitSide = "center"
                side.left.exitSide = nil
                side.bottom.exitSide = nil
                side.right.exitSide = nil
                
                side.top.opening.isOpen = true
                side.left.opening.isOpen = false
                side.bottom.opening.isOpen = false
                side.right.opening.isOpen = false

            case 2:
                
                side.right.color = colors[0]
                side.left.color = nil
                side.bottom.color = nil
                side.top.color = nil
                
                side.right.exitSide = "center"
                side.left.exitSide = nil
                side.bottom.exitSide = nil
                side.top.exitSide = nil
                
                side.right.opening.isOpen = true
                side.left.opening.isOpen = false
                side.bottom.opening.isOpen = false
                side.top.opening.isOpen = false

            case 3:
                
                side.bottom.color = colors[0]
                side.left.color = nil
                side.top.color = nil
                side.right.color = nil
                
                side.bottom.exitSide = "center"
                side.left.exitSide = nil
                side.top.exitSide = nil
                side.right.exitSide = nil
                
                side.bottom.opening.isOpen = true
                side.left.opening.isOpen = false
                side.top.opening.isOpen = false
                side.right.opening.isOpen = false

            case 4:
                
                side.left.color = colors[0]
                side.top.color = nil
                side.bottom.color = nil
                side.right.color = nil
                
                side.left.exitSide = "center"
                side.top.exitSide = nil
                side.bottom.exitSide = nil
                side.right.exitSide = nil
                
                side.left.opening.isOpen = true
                side.top.opening.isOpen = false
                side.bottom.opening.isOpen = false
                side.right.opening.isOpen = false

            default:
                break
            }
            
            
        case .elbow:
            
            switch version {

            case 1:
                
                side.top.opening.isOpen = true
                side.left.opening.isOpen = true
                side.bottom.opening.isOpen = false
                side.right.opening.isOpen = false
                
                side.top.color = colors[0]
                side.left.color = colors[0]
                side.bottom.color = nil
                side.right.color = nil
                
                side.top.exitSide = "left"
                side.left.exitSide = "top"
                side.right.exitSide = nil
                side.bottom.exitSide = nil
                    
            case 2:
                
                side.top.opening.isOpen = true
                side.right.opening.isOpen = true
                side.bottom.opening.isOpen = false
                side.left.opening.isOpen = false
                
                side.top.exitSide = "right"
                side.right.exitSide = "top"
                side.bottom.exitSide = nil
                side.left.exitSide = nil
                
                side.top.color = colors[0]
                side.right.color = colors[0]
                side.bottom.color = nil
                side.left.color = nil
                
            case 3:
                
                side.bottom.opening.isOpen = true
                side.right.opening.isOpen = true
                side.top.opening.isOpen = false
                side.left.opening.isOpen = false
                
                side.bottom.exitSide = "right"
                side.right.exitSide = "bottom"
                side.top.exitSide = nil
                side.left.exitSide = nil
                
                side.bottom.color = colors[0]
                side.right.color = colors[0]
                side.top.color = nil
                side.left.color = nil
                
            case 4:
                
                side.bottom.opening.isOpen = true
                side.left.opening.isOpen = true
                side.top.opening.isOpen = false
                side.right.opening.isOpen = false
                
                side.bottom.exitSide = "left"
                side.left.exitSide = "bottom"
                side.right.exitSide = nil
                side.top.exitSide = nil
                
                side.bottom.color = colors[0]
                side.left.color = colors[0]
                side.top.color = nil
                side.right.color = nil

            default:
                break
            }
            
        case .cross:
            
            side.right.exitSide = "left"
            side.left.exitSide = "right"
            side.top.exitSide = "bottom"
            side.bottom.exitSide = "top"
            
            side.top.opening.isOpen = true
            side.bottom.opening.isOpen = true
            side.left.opening.isOpen = true
            side.right.opening.isOpen = true
            
            switch version {
            
            case 1:
                
                side.left.closing.isOpen = true
                side.right.closing.isOpen = true
                side.top.closing.isOpen = false
                side.bottom.closing.isOpen = false
                
                side.right.color = colors[1]
                side.left.color = colors[1]
                side.top.color = colors[0]
                side.bottom.color = colors[0]

            case 2:
                
                side.right.color = colors[0]
                side.left.color = colors[0]
                side.top.color = colors[1]
                side.bottom.color = colors[1]
                    
                side.left.closing.isOpen = false
                side.right.closing.isOpen = false
                side.top.closing.isOpen = true
                side.bottom.closing.isOpen = true

            case 3:

                side.right.color = colors[1]
                side.left.color = colors[1]
                side.top.color = colors[0]
                side.bottom.color = colors[0]
                
                side.left.closing.isOpen = false
                side.right.closing.isOpen = false
                side.top.closing.isOpen = true
                side.bottom.closing.isOpen = true

            case 4:

                side.right.color = colors[0]
                side.left.color = colors[0]
                side.top.color = colors[1]
                side.bottom.color = colors[1]
                
                side.left.closing.isOpen = true
                side.right.closing.isOpen = true
                side.top.closing.isOpen = false
                side.bottom.closing.isOpen = false
                
            default:
                break
            }

        case .doubleElbow:
                        
            switch version {
                
            case 1:
                
                side.top.opening.isOpen = true
                side.bottom.opening.isOpen = false
                side.left.opening.isOpen = true
                side.right.opening.isOpen = true
                
                side.right.exitSide = "top"
                side.left.exitSide = "top"
                side.top.exitSide = "left"
                side.bottom.exitSide = nil
                
                side.right.color = colors[1]
                side.top.color = colors[0]
                side.left.color = colors[0]
                side.bottom.color = nil

            case 2:

                side.top.opening.isOpen = true
                side.bottom.opening.isOpen = true
                side.left.opening.isOpen = false
                side.right.opening.isOpen = true
                
                side.right.exitSide = "top"
                side.left.exitSide = nil
                side.top.exitSide = "right"
                side.bottom.exitSide = "right"
                
                side.right.color = colors[0]
                side.top.color = colors[0]
                side.bottom.color = colors[1]
                side.left.color = nil
                
            case 3:
                
                side.top.opening.isOpen = false
                side.bottom.opening.isOpen = true
                side.left.opening.isOpen = true
                side.right.opening.isOpen = true
                
                side.right.exitSide = "bottom"
                side.left.exitSide = "bottom"
                side.top.exitSide = nil
                side.bottom.exitSide = "right"
                
                side.right.color = colors[0]
                side.left.color = colors[1]
                side.bottom.color = colors[0]
                side.top.color = nil
                         
            case 4:
                
                side.top.opening.isOpen = true
                side.bottom.opening.isOpen = true
                side.left.opening.isOpen = true
                side.right.opening.isOpen = false
                
                side.right.exitSide = nil
                side.left.exitSide = "bottom"
                side.top.exitSide = "left"
                side.bottom.exitSide = "left"
                
                side.top.color = colors[1]
                side.left.color = colors[0]
                side.bottom.color = colors[0]
                side.right.color = nil

            case 5:
                
                side.top.opening.isOpen = true
                side.bottom.opening.isOpen = false
                side.left.opening.isOpen = true
                side.right.opening.isOpen = true
                
                side.right.exitSide = "top"
                side.left.exitSide = "top"
                side.top.exitSide = "right"
                side.bottom.exitSide = nil
                
                side.right.color = colors[1]
                side.top.color = colors[1]
                side.left.color = colors[0]
                side.bottom.color = nil

            case 6:

                side.top.opening.isOpen = true
                side.bottom.opening.isOpen = true
                side.left.opening.isOpen = false
                side.right.opening.isOpen = true
                
                side.right.exitSide = "bottom"
                side.left.exitSide = nil
                side.top.exitSide = "right"
                side.bottom.exitSide = "right"
                
                side.right.color = colors[1]
                side.top.color = colors[0]
                side.bottom.color = colors[1]
                side.left.color = nil
                
            case 7:

                side.top.opening.isOpen = false
                side.bottom.opening.isOpen = true
                side.left.opening.isOpen = true
                side.right.opening.isOpen = true
                
                side.right.exitSide = "bottom"
                side.left.exitSide = "bottom"
                side.top.exitSide = nil
                side.bottom.exitSide = "left"
                
                side.right.color = colors[0]
                side.left.color = colors[1]
                side.bottom.color = colors[1]
                side.top.color = nil
                
            case 8:
                
                side.top.opening.isOpen = true
                side.bottom.opening.isOpen = true
                side.left.opening.isOpen = true
                side.right.opening.isOpen = false
                
                side.right.exitSide = nil
                side.left.exitSide = "top"
                side.top.exitSide = "left"
                side.bottom.exitSide = "left"
                
                side.top.color = colors[1]
                side.left.color = colors[1]
                side.bottom.color = colors[0]
                side.right.color = nil

            default:
                break
            }
        case .wall:
            
            print()
            
        case .diagElbow:
            
            side.top.opening.isOpen = true
            side.bottom.opening.isOpen = true
            side.left.opening.isOpen = true
            side.right.opening.isOpen = true
            
            switch version {
            
            case 1:
                
                side.right.exitSide = "top"
                side.left.exitSide = "bottom"
                side.top.exitSide = "right"
                side.bottom.exitSide = "left"
                side.right.color = colors[0]
                side.top.color = colors[0]
                side.left.color = colors[1]
                side.bottom.color = colors[1]
                
            case 2:
                    
                side.left.exitSide = "top"
                side.right.exitSide = "bottom"
                side.bottom.exitSide = "right"
                side.top.exitSide = "left"
                side.right.color = colors[1]
                side.top.color = colors[1]
                side.left.color = colors[0]
                side.bottom.color = colors[0]

            case 3:
                
                side.left.exitSide = "bottom"
                side.right.exitSide = "top"
                side.bottom.exitSide = "left"
                side.top.exitSide = "right"
                side.right.color = colors[0]
                side.top.color = colors[0]
                side.left.color = colors[1]
                side.bottom.color = colors[1]
                
            case 4:
                
                side.right.exitSide = "bottom"
                side.left.exitSide = "top"
                side.top.exitSide = "left"
                side.bottom.exitSide = "right"
                side.right.color = colors[1]
                side.top.color = colors[0]
                side.left.color = colors[0]
                side.bottom.color = colors[1]
                
            default:
                break
            }
        default:
            print("DEFAULT")
            break
        }
    }
}

class Side {
    
    var top = Top()
    var bottom = Bottom()
    var left = Left()
    var right = Right()
}

class Top {
    
    var opening = Opening()
    var closing  = Closing()
    var exitSide: String?
    var color: UIColor?
}

class Bottom {
    
    var opening = Opening()
    var closing  = Closing()
    var exitSide: String?
    var color: UIColor?
}

class Left {

    var opening = Opening()
    var closing  = Closing()
    var exitSide: String?
    var color: UIColor?
}

class Right {

    var opening = Opening()
    var closing  = Closing()
    var exitSide: String?
    var color: UIColor?
}

class Opening {
    
    var isOpen = false
}

class Closing {
    
    var isOpen = true
}

class Ball {
    
    var view = BallView()
    var indexes = Indexes()
    var startSide = "unmoved"
    var onColor = UIColor()
    var exited = Bool()
    var piecesPassed = [Piece]()
    var loopedIndexes = [Indexes : Int]()
    var loopedPieces = [Piece]()
    var center = CGPoint()
    var path = UIBezierPath()
    
}

enum Direction {
    
    case up
    case down
    case left
    case right
    case none
}


