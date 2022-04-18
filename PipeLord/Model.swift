//
//  Model.swift
//  PipeLord
//
//  Created by Jeffery Widroff on 06/04/2022.
//


import Foundation
import UIKit

//TODO: Make it that the walls dont slide on the ice

//TODO: Make it that walls fill holes

//TODO: Need to change the hole into an actual hole - Use "addHoleX" (and comment out "addHole") to do this however it seems to be a mask layer and the pieces dont animate well over the mask

//TODO: Make the possibility for more balls in each entrance

//TODO: Give pieces the ability to rotate (May want to consider the cross piece

//TODO: Make a piece that rotates pieces

//TODO: Make it that the pieceMakers can have multiple openings

//TODO: MAKE IT THAT THAT PIECEMAKER CAN ALSO MAKE PIECEMAKERS

//TODO: Make cracks for ice

//TODO: Make a ball stopper piece

//TODO: Make a gradient for the colorChangers view

//TODO: Make the buttons do what they're supposed to do


//TODO: Consider making walls that have the power to move and freeze in place


//TODO: Make it that the pieceMaker can also spit out walls


//TODO: Make the buttons show that theyre being pressed

//TODO: May need to utilize the closing property for the doubleElbow when is comes in from a side but the pivot is the other way


//TODO: Random ColorChanger needs work - SEE EVERYTHING LEVEL! PIECES COME OUT IN BLACK CIRCLES

//TODO: FOR SOME REASON THE BALL DOESNT FOLLOW THE PIECE INTO THE HOLE BUT ONLY WHEN SWIPING UP

//TODO: May want to consider putting in a special piece (possibly one that changes shape/color every time its tapped) when a loop is made or when a line is complete. Whichever is harder

//TODO: May want to consider saving pieces from a level and using all those pieces for the bonus level

//TODO: Need a level to introduce pieces that switch

//TODO: Should diagElbows switch after passing?

//TODO: Finish making color themes for each individual level

//TODO: Consider making pieces stick together

//Fix up menuView

//Need to disable movePiece when balls are moving

//Need to make sure that the check if ball exited works when a ball goes into an infinite loop


//Make ball move automatically if there is a connection complete (Hard to do due to needing to know if pieces switched and which pieces switched)

//Sometimes there are multiple popups trying to come up at the same time since there is multiple reasons why the user has lost (Ex losing an entrance piece as a last moveable piece)

protocol ModelDelegate {
    func setUpGameViews(board: Board)
    func setUpControlViews()
    func setUpPiecesView()
    func movePieceView(piece: Piece)
    func moveBallView(ball: Ball, piece: Piece, startSide: String, endSide: String)
    func addPieceView(piece: Piece)
    func resetPieceMakerView(piece: Piece)
    func removeView(view: UIView)
    func runPopUpView(title: String, message: String)
    func clearPiecesAnimation(view: UIView)
    func replacePieceView(piece: Piece)
    func changeViewColor(piece: Piece, ball: Ball)
    func changeAnimationSpeed(slowerOrFaster: String)
    func crashBallViewIntoCross(piece: Piece, ball: Ball)
    func removeViews()
    func updateLevelInfo(name: String, moves: String)
    func updateMovesLeftLabel(moves: String)
    func addSwipeGestureRecognizer(view: UIView)
    func removeHole(indexes: Indexes)
    
}

class Model {
    
    var board = Board()
    var level = Level()
    var delegate: ModelDelegate?
    var gameOver = false
    var possibleLoopPieces = [Piece]()
    var loadingMode = true
    var levelModel = LevelModel()
    let defaults = UserDefaults.standard
    var moveStarted = false
    var infiniteMoves = Bool()
    var gameIsLoading = true
    
    init(){
        
    }
    
    func setUpGame() {
        self.level.number = self.defaults.integer(forKey: "level")
        self.getLevel()
        self.setBoard()
    }
    
    func updateLevelInfo() {
        
        let name = levelModel.levelNames[level.number]
        let moves = "\(board.moves)"
        delegate?.updateLevelInfo(name: name, moves: moves)
    }
    
    
    
    
    func showLoadingAnimation() {
        
        self.board = Board()
        self.board.heightSpaces = 8
        self.board.widthSpaces = 4
        
        let piece1 = Piece(indexes: Indexes(x: 1, y: 4), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
                
        let piece2 = Piece(indexes: Indexes(x: 1, y: 3), shape: .doubleElbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
        
        let piece3 = Piece(indexes: Indexes(x: 2, y: 4), shape: .elbow, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
        
        let piece4 = Piece(indexes: Indexes(x: 2, y: 3), shape: .elbow, colors: [UIColor.red], version: 2, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
        
        let piece5 = Piece(indexes: Indexes(x: 1, y: 2), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "bottom", doesPivot: false)
        
        board.pieces.append(piece1)
        board.pieces.append(piece2)
        board.pieces.append(piece3)
        board.pieces.append(piece4)
        board.pieces.append(piece5)

        let ball = Ball()
        board.balls.append(ball)

        for piece in board.pieces {

            if piece.shape == .entrance {

                ball.indexes = piece.indexes
                ball.onColor = piece.colors[0]
            }
        }

        delegate?.setUpGameViews(board: self.board)
        delegate?.setUpPiecesView()
        moveBall(ball: ball, startSide: "unmoved")
    }
    
    func getLevel() {
        
        levelModel = LevelModel()
        self.board = levelModel.returnBoard(levelNumber: level.number)
    }
    
    func setBoard() {
        
        delegate?.setUpGameViews(board: self.board)
        delegate?.setUpControlViews()
        delegate?.setUpPiecesView()
        updateLevelInfo()
    }
    
    func setPieceSides(piece: Piece) {
        
        switch piece.shape {
        
        case .elbow:
            
            switch piece.version {
            
            case 1:
                
                //Top Pivot
                if piece.currentSwitch == 1 {
                    
                    piece.side.top.opening.isOpen = true
                    piece.side.left.opening.isOpen = true
                    piece.side.top.color = piece.colors[0]
                    piece.side.left.color = piece.colors[0]
                    piece.side.bottom.color = nil
                    piece.side.right.color = nil
                    piece.side.top.exitSide = "left"
                    piece.side.left.exitSide = "top"
                    piece.side.right.exitSide = nil
                    piece.side.bottom.exitSide = nil
                    
                } else if piece.currentSwitch == 2 {
                    
                    piece.side.top.opening.isOpen = true
                    piece.side.right.opening.isOpen = true
                    piece.side.top.color = piece.colors[0]
                    piece.side.right.color = piece.colors[0]
                    piece.side.bottom.color = nil
                    piece.side.left.color = nil
                    piece.side.top.exitSide = "right"
                    piece.side.right.exitSide = "top"
                    piece.side.bottom.exitSide = nil
                    piece.side.left.exitSide = nil
                }
                
            case 2:
                
                //Left Pivot
                if piece.currentSwitch == 1 {
                    
                    piece.side.bottom.opening.isOpen = true
                    piece.side.left.opening.isOpen = true
                    piece.side.bottom.exitSide = "left"
                    piece.side.left.exitSide = "bottom"
                    piece.side.right.exitSide = nil
                    piece.side.top.exitSide = nil
                    piece.side.bottom.color = piece.colors[0]
                    piece.side.left.color = piece.colors[0]
                    piece.side.top.color = nil
                    piece.side.right.color = nil
                    
                } else if piece.currentSwitch == 2 {
                    
                    piece.side.top.opening.isOpen = true
                    piece.side.left.opening.isOpen = true
                    piece.side.top.exitSide = "left"
                    piece.side.left.exitSide = "top"
                    piece.side.right.exitSide = nil
                    piece.side.bottom.exitSide = nil
                    piece.side.top.color = piece.colors[0]
                    piece.side.left.color = piece.colors[0]
                    piece.side.bottom.color = nil
                    piece.side.right.color = nil
                }
                
            case 3:
                
                //Bottom Pivot
                if piece.currentSwitch == 1 {
                    
                    piece.side.bottom.opening.isOpen = true
                    piece.side.right.opening.isOpen = true
                    piece.side.bottom.exitSide = "right"
                    piece.side.right.exitSide = "bottom"
                    piece.side.top.exitSide = nil
                    piece.side.left.exitSide = nil
                    piece.side.bottom.color = piece.colors[0]
                    piece.side.right.color = piece.colors[0]
                    piece.side.top.color = nil
                    piece.side.left.color = nil

                } else if piece.currentSwitch == 2 {
                    
                    piece.side.bottom.opening.isOpen = true
                    piece.side.left.opening.isOpen = true
                    piece.side.bottom.exitSide = "left"
                    piece.side.left.exitSide = "bottom"
                    piece.side.right.exitSide = nil
                    piece.side.top.exitSide = nil
                    piece.side.bottom.color = piece.colors[0]
                    piece.side.left.color = piece.colors[0]
                    piece.side.top.color = nil
                    piece.side.right.color = nil
                }
                
            case 4:
                
                //Right Pivot
                if piece.currentSwitch == 1 {
                    
                    piece.side.top.opening.isOpen = true
                    piece.side.right.opening.isOpen = true
                    piece.side.top.exitSide = "right"
                    piece.side.right.exitSide = "top"
                    piece.side.bottom.exitSide = nil
                    piece.side.left.exitSide = nil
                    piece.side.top.color = piece.colors[0]
                    piece.side.right.color = piece.colors[0]
                    piece.side.bottom.color = nil
                    piece.side.left.color = nil

                } else if piece.currentSwitch == 2 {
                    
                    piece.side.bottom.opening.isOpen = true
                    piece.side.right.opening.isOpen = true
                    piece.side.bottom.exitSide = "right"
                    piece.side.right.exitSide = "bottom"
                    piece.side.top.exitSide = nil
                    piece.side.left.exitSide = nil
                    piece.side.bottom.color = piece.colors[0]
                    piece.side.right.color = piece.colors[0]
                    piece.side.top.color = nil
                    piece.side.left.color = nil
                }
            default:
                break
            }
            
        case .cross:
            
            piece.side.right.exitSide = "left"
            piece.side.left.exitSide = "right"
            piece.side.top.exitSide = "bottom"
            piece.side.bottom.exitSide = "top"
            
            piece.side.right.color = piece.colors[1]
            piece.side.left.color = piece.colors[1]
            piece.side.top.color = piece.colors[0]
            piece.side.bottom.color = piece.colors[0]
            
            piece.side.top.opening.isOpen = true
            piece.side.bottom.opening.isOpen = true
            piece.side.left.opening.isOpen = true
            piece.side.right.opening.isOpen = true
            
            switch piece.version {
            
            case 1, 3:
                
                if piece.currentSwitch == 1 {
                    
                    //Horizontal Pipe on top
                    piece.side.left.closing.isOpen = true
                    piece.side.right.closing.isOpen = true
                    piece.side.top.closing.isOpen = false
                    piece.side.bottom.closing.isOpen = false
                    
                } else if piece.currentSwitch == 2 {
                    
                    //Vertical Pipe on top
                    piece.side.left.closing.isOpen = false
                    piece.side.right.closing.isOpen = false
                    piece.side.top.closing.isOpen = true
                    piece.side.bottom.closing.isOpen = true
                }

            case 2, 4:
                
                if piece.currentSwitch == 1 {
                    
                    //Horizontal Pipe on top
                    piece.side.left.closing.isOpen = true
                    piece.side.right.closing.isOpen = true
                    piece.side.top.closing.isOpen = false
                    piece.side.bottom.closing.isOpen = false
                    
                } else if piece.currentSwitch == 2 {
                    
                    //Vertical Pipe on top
                    piece.side.left.closing.isOpen = false
                    piece.side.right.closing.isOpen = false
                    piece.side.top.closing.isOpen = true
                    piece.side.bottom.closing.isOpen = true
                }
                
            default:
                break
                
            }
            
        case .stick:
            
            switch piece.version {
            case 1, 3:
                
                piece.side.right.exitSide = "left"
                piece.side.left.exitSide = "right"
                piece.side.right.color = piece.colors[0]
                piece.side.left.color = piece.colors[0]
                piece.side.left.opening.isOpen = true
                piece.side.right.opening.isOpen = true
                
            case 2, 4:
                
                piece.side.top.exitSide = "bottom"
                piece.side.bottom.exitSide = "top"
                piece.side.top.color = piece.colors[0]
                piece.side.bottom.color = piece.colors[0]
                piece.side.top.opening.isOpen = true
                piece.side.bottom.opening.isOpen = true

            default:
                break
            }
            
        case .doubleElbow:
            
            switch piece.version {
            case 1:
                                
                if piece.currentSwitch == 1 {
                                
                    //Top Left
                    piece.side.top.opening.isOpen = true
                    piece.side.bottom.opening.isOpen = false
                    piece.side.left.opening.isOpen = true
                    piece.side.right.opening.isOpen = true
                    piece.side.right.exitSide = "top"
                    piece.side.left.exitSide = "top"
                    piece.side.top.exitSide = "left"
                    piece.side.bottom.exitSide = nil
                    piece.side.right.color = piece.colors[1]
                    piece.side.top.color = piece.colors[0]
                    piece.side.left.color = piece.colors[0]
                    
                } else if piece.currentSwitch == 2 {
                    
                    //Top Right
                    piece.side.top.opening.isOpen = true
                    piece.side.bottom.opening.isOpen = false
                    piece.side.left.opening.isOpen = true
                    piece.side.right.opening.isOpen = true
                    piece.side.right.exitSide = "top"
                    piece.side.left.exitSide = "top"
                    piece.side.top.exitSide = "right"
                    piece.side.bottom.exitSide = nil
                    piece.side.right.color = piece.colors[1]
                    piece.side.top.color = piece.colors[1]
                    piece.side.left.color = piece.colors[0]
                }
                
            case 2:

                if piece.currentSwitch == 1 {
                    
                    //left bottom
                    piece.side.top.opening.isOpen = true
                    piece.side.bottom.opening.isOpen = true
                    piece.side.left.opening.isOpen = true
                    piece.side.right.opening.isOpen = false
                    piece.side.right.exitSide = nil
                    piece.side.left.exitSide = "bottom"
                    piece.side.top.exitSide = "left"
                    piece.side.bottom.exitSide = "left"
                    piece.side.top.color = piece.colors[1]
                    piece.side.left.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[0]
                    
                } else if piece.currentSwitch == 2 {
                    
                    //left top
                    piece.side.top.opening.isOpen = true
                    piece.side.bottom.opening.isOpen = true
                    piece.side.left.opening.isOpen = true
                    piece.side.right.opening.isOpen = false
                    piece.side.right.exitSide = nil
                    piece.side.left.exitSide = "top"
                    piece.side.top.exitSide = "left"
                    piece.side.bottom.exitSide = "left"
                    piece.side.top.color = piece.colors[1]
                    piece.side.left.color = piece.colors[1]
                    piece.side.bottom.color = piece.colors[0]
                }
                
            case 3:

                if piece.currentSwitch == 1 {
                    
                    //Bottom Left on top
                    piece.side.top.opening.isOpen = false
                    piece.side.bottom.opening.isOpen = true
                    piece.side.left.opening.isOpen = true
                    piece.side.right.opening.isOpen = true
                    piece.side.right.exitSide = "bottom"
                    piece.side.left.exitSide = "bottom"
                    piece.side.top.exitSide = nil
                    piece.side.bottom.exitSide = "left"
                    piece.side.right.color = piece.colors[1]
                    piece.side.left.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[0]
                    
                } else if piece.currentSwitch == 2 {
                    
                    //Bottom right on top
                    piece.side.top.opening.isOpen = false
                    piece.side.bottom.opening.isOpen = true
                    piece.side.left.opening.isOpen = true
                    piece.side.right.opening.isOpen = true
                    piece.side.right.exitSide = "bottom"
                    piece.side.left.exitSide = "bottom"
                    piece.side.top.exitSide = nil
                    piece.side.bottom.exitSide = "right"
                    piece.side.right.color = piece.colors[1]
                    piece.side.left.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[1]
                }
                
            case 4:
                
                if piece.currentSwitch == 1 {
                    
                    //Right top
                    piece.side.top.opening.isOpen = true
                    piece.side.bottom.opening.isOpen = true
                    piece.side.left.opening.isOpen = false
                    piece.side.right.opening.isOpen = true
                    piece.side.right.exitSide = "top"
                    piece.side.left.exitSide = nil
                    piece.side.top.exitSide = "right"
                    piece.side.bottom.exitSide = "right"
                    piece.side.right.color = piece.colors[0]
                    piece.side.top.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[1]
                    
                } else if piece.currentSwitch == 2 {
                    
                    //Right Bottom
                    piece.side.top.opening.isOpen = true
                    piece.side.bottom.opening.isOpen = true
                    piece.side.left.opening.isOpen = false
                    piece.side.right.opening.isOpen = true
                    piece.side.right.exitSide = "bottom"
                    piece.side.left.exitSide = nil
                    piece.side.top.exitSide = "right"
                    piece.side.bottom.exitSide = "right"
                    piece.side.right.color = piece.colors[1]
                    piece.side.top.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[1]
                }
                
            default:
                break
            }
            
        case .diagElbow:
            
            piece.side.top.opening.isOpen = true
            piece.side.bottom.opening.isOpen = true
            piece.side.left.opening.isOpen = true
            piece.side.right.opening.isOpen = true
            
            switch piece.version {
            
            case 1, 3:
                
                //Pivots on left and right
                if piece.currentSwitch == 1 {

                    piece.side.right.exitSide = "top"
                    piece.side.left.exitSide = "bottom"
                    piece.side.top.exitSide = "right"
                    piece.side.bottom.exitSide = "left"
                    piece.side.right.color = piece.colors[0]
                    piece.side.top.color = piece.colors[0]
                    piece.side.left.color = piece.colors[1]
                    piece.side.bottom.color = piece.colors[1]
                    
                } else if piece.currentSwitch == 2 {

                    piece.side.right.exitSide = "bottom"
                    piece.side.left.exitSide = "top"
                    piece.side.top.exitSide = "left"
                    piece.side.bottom.exitSide = "right"
                    piece.side.right.color = piece.colors[0]
                    piece.side.top.color = piece.colors[1]
                    piece.side.left.color = piece.colors[1]
                    piece.side.bottom.color = piece.colors[0]
                }
                
            case 2, 4:
                
                //Pivots on top and bottom
                if piece.currentSwitch == 1 {
                    
                    piece.side.left.exitSide = "top"
                    piece.side.right.exitSide = "bottom"
                    piece.side.bottom.exitSide = "right"
                    piece.side.top.exitSide = "left"
                    piece.side.right.color = piece.colors[1]
                    piece.side.top.color = piece.colors[0]
                    piece.side.left.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[1]
                
                } else if piece.currentSwitch == 2 {

                    piece.side.left.exitSide = "bottom"
                    piece.side.right.exitSide = "top"
                    piece.side.bottom.exitSide = "left"
                    piece.side.top.exitSide = "right"
                    piece.side.right.color = piece.colors[0]
                    piece.side.top.color = piece.colors[0]
                    piece.side.left.color = piece.colors[1]
                    piece.side.bottom.color = piece.colors[1]
                }
                    
            default:
                break
            }
            
            
        case .colorChanger:
            
            switch piece.version {
            
            case 1, 3:
                
                //Horizontal Line
                if piece.currentSwitch == 1 {

                    piece.side.left.color = piece.colors[0]
                    piece.side.right.color = piece.colors[1]
                    piece.side.left.exitSide = "right"
                    piece.side.right.exitSide = "left"
                    piece.side.left.opening.isOpen = true
                    piece.side.right.opening.isOpen = true
                    
                } else if piece.currentSwitch == 2 {

                    piece.side.left.color = piece.colors[1]
                    piece.side.right.color = piece.colors[0]
                    piece.side.left.exitSide = "right"
                    piece.side.right.exitSide = "left"
                    piece.side.left.opening.isOpen = true
                    piece.side.right.opening.isOpen = true
                }
                
            case 2, 4:
                
                //Vertical Line
                if piece.currentSwitch == 1 {
                    
                    piece.side.top.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[1]
                    piece.side.top.exitSide = "bottom"
                    piece.side.bottom.exitSide = "top"
                    piece.side.top.opening.isOpen = true
                    piece.side.bottom.opening.isOpen = true
                
                } else if piece.currentSwitch == 2 {

                    piece.side.top.color = piece.colors[1]
                    piece.side.bottom.color = piece.colors[0]
                    piece.side.top.exitSide = "bottom"
                    piece.side.bottom.exitSide = "top"
                    piece.side.top.opening.isOpen = true
                    piece.side.bottom.opening.isOpen = true
                }
            default:
                break
            }
        default:
            break
        }
    }
    
    func setPieceSwitches(piece: Piece) {
        
        switch piece.shape {
        
        case .diagElbow, .elbow, .colorChanger:
            
            let pivotDecision = Int(arc4random_uniform(UInt32(2))) + 1
            
            switch pivotDecision {
            case 1:
                piece.switches = 2
                piece.currentSwitch = Int(arc4random_uniform(UInt32(2))) + 1
                
            case 2:
                piece.switches = 1
                piece.currentSwitch = 1
                piece.doesPivot = false
                
            default:
                break
            }
            
        case .doubleElbow:

            piece.switches = 2
            piece.currentSwitch = Int(arc4random_uniform(UInt32(2))) + 1
            
        case .cross:
            
            piece.switches = 2
            piece.currentSwitch = Int(arc4random_uniform(UInt32(2))) + 1
            
        case .stick:
            
            piece.switches = 1
            piece.currentSwitch = 1
            
        default:
            break
        }
    }
    
    func setPieceShape(piece: Piece) {
        
        let version = Int(arc4random_uniform(UInt32(4))) + 1
        let randomShapes:[Shape] = board.randomPieceShapes
        piece.shape = randomShapes[Int(arc4random_uniform(UInt32(randomShapes.count)))]
        piece.version = version
    }
    
    func setPieceColor(piece: Piece) {
        
        let randomColors:[UIColor] = board.randomPieceColors
        let randomColor1 = randomColors[Int(arc4random_uniform(UInt32(randomColors.count - 1)))]
        let randomColor2 = randomColors[Int(arc4random_uniform(UInt32(randomColors.count)))]
        piece.colors = [randomColor1, randomColor2]
    }
    
    func isNextSpaceBlocked(direction: UISwipeGestureRecognizer.Direction, indexes: Indexes) -> Bool {
        
        var bool = true

        switch direction {
        case .up:
            if board.pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x, y: indexes.y! - 1)
            }){
                bool = false
            }
            
        case .down:
            if board.pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x, y: indexes.y! + 1)
            }){
                bool = false
            }
            
        case .left:
            if board.pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x! - 1, y: indexes.y)
            }){
                bool = false
            }
            
        case .right:
            if board.pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x! + 1, y: indexes.y)
            }){
                bool = false
            }
        default:
            break
        }
        return bool
    }
    
    func getPieceInfo(index: Indexes) -> Piece {
        
        var piece = Piece()
        
        for pieceX in board.pieces {
            
            if pieceX.indexes == index {
                
                piece = pieceX
            }
        }
        return piece
    }
    
    func checkForIce(piece: Piece) -> Bool {

        var bool = false

        if board.iceLocations.contains(where: { (index) -> Bool in
            index == piece.indexes
        }) {
            bool = true
        }
        return bool
    }
    
    func checkForHole(piece: Piece, direction: Direction) -> Bool {

        
        var bool = false
        
        if board.holeLocations.contains(where: { (index) -> Bool in
            index == piece.indexes
        }) {
            
            
            if piece.shape == .wall {
                
                
                //UP TO HERE - THE WALLS INDEXES NEED TO UPDATE BEFORE WE CAN 'Fill' the hole
                
                
                
                
                //Get CGPoint of the center of where the piece would be

                
                
                
                
                
                var indexOfHole = piece.indexes
                
                
                
                
                bool = false
                
                
//                switch direction {
//                case .up:
//
//                    
//                    indexOfHole = Indexes(x: piece.indexes.x, y: piece.indexes.y! - 1)
//                    
//                case .down:
//
//
//                    indexOfHole = Indexes(x: piece.indexes.x!, y: piece.indexes.y! + 1)
//
//                case .left:
//
//                    indexOfHole = Indexes(x: piece.indexes.x! - 1, y: piece.indexes.y!)
//
//
//                case .right:
//
//                    indexOfHole = Indexes(x: piece.indexes.x! + 1, y: piece.indexes.y!)
//
//                case .none:
//                    break
//                }
                
                
                
                delegate?.removeHole(indexes: indexOfHole)
                
                
                var int = 0
                
                for holeLocation in board.holeLocations {
                    
                    
                    
                    if holeLocation == indexOfHole {
                        
                        print("indexOfHole \(indexOfHole)")
                        
                        board.holeLocations.remove(at: int)
                    }
                    
                    int += 1
                }
                
//                board.holeLocations.remove(at: <#T##Int#>)
                
                
            } else {
                
                bool = true
            }
            
            
        }
        return bool
    }
    
    func resetPieceMaker(piece: Piece) {
        
        print("Reset called")
        
        let nextPiece = Piece()
        nextPiece.indexes = piece.indexes
        setPieceShape(piece: nextPiece)
        
        print(nextPiece.shape)
        
        
        setPieceColor(piece: nextPiece)
        
        print(nextPiece.colors)

        setPieceSwitches(piece: nextPiece)
        setPieceSides(piece: nextPiece)
        piece.nextPiece = nextPiece
        delegate?.resetPieceMakerView(piece: piece)
    }
    
    func updateMovesLeft() {
        
//        print("board.moves \(board.moves)")
        
        var movesX = String()
        
        if moveStarted == true {
            
            if board.moves != 0 {
                
                board.moves -= 1
                movesX = "\(board.moves)"
                
                if board.moves == 0 {
                    
                    let delayedTime = DispatchTime.now() + .milliseconds(Int(500))

                    DispatchQueue.main.asyncAfter(deadline: delayedTime) {
                        
                        for ball in self.board.balls {

                            self.moveBall(ball: ball, startSide: "unmoved")
                        }
                    }
                }
                
            } else {
                
                movesX = "∞"
                
            }
            
            delegate?.updateMovesLeftLabel(moves: movesX)
            
            moveStarted = false
        }
    }
    
    func movePiecesHelper(piece: Piece, direction: UISwipeGestureRecognizer.Direction) {
        
        switch direction {
        
        case .up:
            
            let spaceIsntBlocked = isNextSpaceBlocked(direction: .up, indexes: piece.indexes)
                
                if spaceIsntBlocked {
                                        
                    if piece.shape != .pieceMaker {
                        
                        if piece.isLocked == false {
                            
                            updateMovesLeft()
                            
                            piece.indexes.y = piece.indexes.y! - 1
                            
                            if piece.shape == .entrance {
                                
                                for ball in board.balls {
                                    
                                    if ball.indexes == Indexes(x: piece.indexes.x, y: piece.indexes.y! + 1) {
                                        
                                        ball.indexes = piece.indexes
                                    }
                                }
                            }
                            
                            if checkForIce(piece: piece) == true {
                                delegate?.movePieceView(piece: piece)
                                movePiecesHelper(piece: piece, direction: direction)
                                return
                            }
                            
                            if checkForHole(piece: piece, direction: .up) == true {
                                
                                deletePiece(piece: piece)
                                
                                if piece.shape == .entrance {
                                    
//                                    board.balls.removeAll()
                                    delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                                    break
                                    
                                }
                            }
                        }
                        
                    } else {
                        
                        if piece.version == 3 {
                                                        
                            if piece.nextPiece != nil {
                                
                                updateMovesLeft()
                                
                                let newPiece = piece.nextPiece!
                                
                                newPiece.view = ShapeView(frame: piece.view.frame, piece: newPiece)
                                                                
                                delegate?.addPieceView(piece: newPiece)
                                
                                board.pieces.append(newPiece)
                                
                                newPiece.indexes.y = newPiece.indexes.y! - 1
                                
                                delegate?.movePieceView(piece: newPiece)
                                
                                if checkForIce(piece: newPiece) == true {
                                    movePiecesHelper(piece: newPiece, direction: direction)
                                    return
                                }
                                
                                if checkForHole(piece: newPiece, direction: .down) == true {
                                    
                                    deletePiece(piece: newPiece)
                                    
                                    if piece.shape == .entrance {
//                                        board.balls.removeAll()
                                        delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                                        break
                                    }
                                }
                                resetPieceMaker(piece: piece)
                            }
                        }
                    }
                    
                } else {
                    return
                }
            
        case .down:
            
            let spaceIsntBlocked = isNextSpaceBlocked(direction: .down, indexes: piece.indexes)

                if spaceIsntBlocked {
                    
                    if piece.shape != .pieceMaker {
                                                
                        if piece.isLocked == false {
                            
                            updateMovesLeft()
                            
                            piece.indexes.y = piece.indexes.y! + 1
                            
                            if piece.shape == .entrance {
                                
                                for ball in board.balls {
                                    
                                    if ball.indexes == Indexes(x: piece.indexes.x, y: piece.indexes.y! - 1) {
                                        
                                        ball.indexes = piece.indexes
                                    }
                                }
                            }
                            
                            if checkForIce(piece: piece) == true {
                                
                                delegate?.movePieceView(piece: piece)
                                movePiecesHelper(piece: piece, direction: direction)
                                return
                            }
                            
                            if checkForHole(piece: piece, direction: .down) == true {
                                
                                deletePiece(piece: piece)
                                
                                if piece.shape == .entrance {
                                    delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                                    break
                                }
                            }
                        }
                        
                    } else {
                                                
                        if piece.version == 1 {
                            
                            if piece.nextPiece != nil {

                                updateMovesLeft()

                                let newPiece = piece.nextPiece!
                                
                                newPiece.view = ShapeView(frame: piece.view.frame, piece: newPiece)

                                delegate?.addPieceView(piece: newPiece)
                                
                                board.pieces.append(newPiece)
                                
                                newPiece.indexes.y = newPiece.indexes.y! + 1
                                
                                delegate?.movePieceView(piece: newPiece)
                                
                                if checkForIce(piece: newPiece) == true {
                                    
                                    movePiecesHelper(piece: newPiece, direction: direction)
                                    return
                                }
                                
                                if checkForHole(piece: newPiece, direction: .down) == true {
                                    
                                    deletePiece(piece: newPiece)
                                    
                                    if piece.shape == .entrance {
                                        delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                                        break
                                    }
                                }
                                resetPieceMaker(piece: piece)
                            }
                        }
                    }
                    
                } else {
                    return
                }
            
        case .left:
            
            let spaceIsntBlocked = isNextSpaceBlocked(direction: .left, indexes: piece.indexes)

                if spaceIsntBlocked {
                    
                    if piece.shape != .pieceMaker {
                        
                        if piece.isLocked == false {
                            
                            updateMovesLeft()

                            piece.indexes.x = piece.indexes.x! - 1
                            
                            if piece.shape == .entrance {
                                
                                for ball in board.balls {
                                    
                                    if ball.indexes == Indexes(x: piece.indexes.x! + 1, y: piece.indexes.y) {
                                        
                                        ball.indexes = piece.indexes
                                    }
                                }
                            }
                            
                            if checkForIce(piece: piece) == true {
                                delegate?.movePieceView(piece: piece)
                                movePiecesHelper(piece: piece, direction: direction)
                            }
                            
                            if checkForHole(piece: piece, direction: .left) == true {
                                
                                deletePiece(piece: piece)
                                
                                if piece.shape == .entrance {
                                    delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                                    break
                                }
                            }
                        }
                        
                    } else {
                        
                        if piece.version == 2 {
                            
                            if piece.nextPiece != nil {
                                
                                updateMovesLeft()

                                let newPiece = piece.nextPiece!
                                
                                newPiece.view = ShapeView(frame: piece.view.frame, piece: newPiece)

                                delegate?.addPieceView(piece: newPiece)

                                board.pieces.append(newPiece)
                                
                                newPiece.indexes.x = newPiece.indexes.x! - 1
                                
                                delegate?.movePieceView(piece: newPiece)

                                if checkForIce(piece: newPiece) == true {
                                    movePiecesHelper(piece: newPiece, direction: direction)
                                }
                                
                                if checkForHole(piece: newPiece, direction: .left) == true {
                                    
                                    deletePiece(piece: newPiece)
                                    
                                    if piece.shape == .entrance {
                                        delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                                        break
                                    }
                                }
                                resetPieceMaker(piece: piece)
                            }
                        }
                    }
                    
                } else {
                    return
                }
            
        case .right:
            
            let spaceIsntBlocked = isNextSpaceBlocked(direction: .right, indexes: piece.indexes)
                
                if spaceIsntBlocked {
                    
                    if piece.shape != .pieceMaker {
                        
                        if piece.isLocked == false {
                            
                            updateMovesLeft()
                           
                            piece.indexes.x = piece.indexes.x! + 1
                            
                            if piece.shape == .entrance {
                                
                                for ball in board.balls {
                                    
                                    if ball.indexes == Indexes(x: piece.indexes.x! - 1, y: piece.indexes.y) {
                                        
                                        ball.indexes = piece.indexes
                                    }
                                }
                            }
                            
                            if checkForIce(piece: piece) == true {
                                delegate?.movePieceView(piece: piece)
                                movePiecesHelper(piece: piece, direction: direction)
                            }
                            
                            if checkForHole(piece: piece, direction: .right) == true {
                                
                                deletePiece(piece: piece)
                                
                                if piece.shape == .entrance {
                                    delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                                    break
                                }
                            }
                        }
                        
                    } else {
                        
                        if piece.nextPiece != nil {
                            
                            if piece.version == 4 {
                                
                                updateMovesLeft()

                                let newPiece = piece.nextPiece!
                                
                                newPiece.view = ShapeView(frame: piece.view.frame, piece: newPiece)

                                delegate?.addPieceView(piece: newPiece)
                                
                                board.pieces.append(newPiece)
                                
                                newPiece.indexes.x = newPiece.indexes.x! + 1
                                
                                delegate?.movePieceView(piece: newPiece)

                                if checkForIce(piece: newPiece) == true {
                                    movePiecesHelper(piece: newPiece, direction: direction)
                                }
                                
                                if checkForHole(piece: newPiece, direction: .right) == true {
                                    
                                    deletePiece(piece: newPiece)
                                    
                                    if piece.shape == .entrance {
                                        delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                                        break
                                    }
                                    
                                  
                                }
                                resetPieceMaker(piece: piece)
                            }
                        }
                    }
                    
                } else {
                    return
                }
            
        default:
            break
        }
    }
    
    func deletePiece(piece: Piece) {
        
//        board.view.bringSubviewToFront(piece.view)
        
        board.pieces.removeAll { (piece) -> Bool in
            
            if piece.indexes.x! < 0 || piece.indexes.x! > board.widthSpaces - 1 || piece.indexes.y! < 0 || piece.indexes.y! > board.heightSpaces - 1 {
                
                delegate?.removeView(view: piece.view)
                
                return true
            }
            return false
        }
        
        board.pieces.removeAll { (piece) -> Bool in

            for holeLocation in board.holeLocations {

                if holeLocation == piece.indexes {

                    delegate?.removeView(view: piece.view)
                    return true
                }
            }
            return false
        }
    }
    
    func deleteBall(ball: Ball) {
        
        board.balls.removeAll { (ball) -> Bool in
            
            if ball.indexes.x! < 0 || ball.indexes.x! > board.widthSpaces - 1 || ball.indexes.y! < 0 || ball.indexes.y! > board.heightSpaces - 1 {
                
                delegate?.removeView(view: ball.view)
                return true
            }
            return false
        }
        
        board.balls.removeAll { (ball) -> Bool in

            for holeLocation in board.holeLocations {

                if holeLocation == ball.indexes {

                    delegate?.removeView(view: ball.view)

//                    delegate?.removeBall(ball: ball)
                    return true
                }
            }
            return false
        }
    }
    
    func movePiece(direction: UISwipeGestureRecognizer.Direction) {
        
        moveStarted = true
        
        switch direction {
            
        case .up:
            
            board.pieces.sort { (piece1, piece2) -> Bool in
                piece1.indexes.y! < piece2.indexes.y!
            }

        case .down:
            
            board.pieces.sort { (piece1, piece2) -> Bool in
                piece1.indexes.y! > piece2.indexes.y!
            }

        case .left:
            
            board.pieces.sort { (piece1, piece2) -> Bool in
                piece1.indexes.x! < piece2.indexes.x!
            }

        case .right:
            
            board.pieces.sort { (piece1, piece2) -> Bool in
                piece1.indexes.x! > piece2.indexes.x!
            }

        default:
            break
        }
        
        for piece in board.pieces {
            
            
            
            movePiecesHelper(piece: piece, direction: direction)
            delegate?.movePieceView(piece: piece)
        }
        
        let gameIsOver = check4GameOver().0
        let message = check4GameOver().1
        if gameIsOver {

            delegate?.runPopUpView(title: message, message: "TRY AGAIN?")
            gameOver = false
            return
        }
    }
    

    
    func check4GameOver() -> (Bool, String) {
        
        var message = ""
        var bool = false
        var moveablePieceCount = 0
        
        if board.balls.count == 0 {
            
            bool = true
            message = "You lost your ball!"
            return (bool, message)
        }
        
        for piece in board.pieces {
            
            if piece.isLocked == false {
                moveablePieceCount += 1
            }
        }
        
        if moveablePieceCount == 0 {
            bool = true
            message = "No more pieces to move!"
            return (bool, message)
        }
        
        return (bool, message)
    }
    
    func addToPiecesPassed(ball: Ball, piece: Piece) {
        
        if !ball.piecesPassed.contains(where: { (pieceX) -> Bool in
            piece.indexes == pieceX.indexes
        }) {
            
            ball.piecesPassed.append(piece)
        }
        else {
            
            ball.possibleLoopedIndexes.append(piece.indexes)
            
            delegate?.changeViewColor(piece: piece, ball: ball)
            delegate?.changeAnimationSpeed(slowerOrFaster: "faster")
            
            if ball.loopedIndexes[piece.indexes] != nil {
                
                ball.loopedIndexes[piece.indexes]! += 1
                
            } else {
                
                ball.loopedIndexes[piece.indexes] = 1
                delegate?.changeAnimationSpeed(slowerOrFaster: "slower")
            }
        }
    }
    
    func check4EndlessLoop(ball: Ball) -> Bool {
        
        var bool = false
        
        for index in ball.loopedIndexes {
            
            if index.value >= 10 {
                
                let piece = getPieceInfo(index: index.key)
                ball.loopedPieces.append(piece)
            }
        }
        if ball.loopedPieces.count >= 10 {

            if !ball.loopedIndexes.contains(where: { (key, value) -> Bool in
                value == 9
            }) {
                bool = true
            }
        }
        return bool
    }
    
    func removePiecesInPath(ball: Ball) {
        
        for piece in ball.piecesPassed {
            
            delegate?.removeView(view: piece.view)
            
            board.pieces.removeAll { (pieceX) -> Bool in
                pieceX.indexes == piece.indexes
            }
        }
        
        board.balls.removeAll { (ballX) -> Bool in
            ball.indexes == ballX.indexes
        }
        
        delegate?.removeView(view: ball.view)
        delegate?.changeAnimationSpeed(slowerOrFaster: "slower")
    }
    
    func moveBall(ball: Ball, startSide: String) {
        
        let piece = getPieceInfo(index: ball.indexes)
        
        switch startSide {
        
        case "unmoved":
            
            let startSide = "center"
            
            let endSide = piece.opening
            
            switch piece.opening {
            
            case "top":
                ball.onColor = piece.side.top.color!
            case "bottom":
                ball.onColor = piece.side.bottom.color!
            case "left":
                ball.onColor = piece.side.left.color!
            case "right":
                ball.onColor = piece.side.right.color!
            default:
                break
            }
            
            addToPiecesPassed(ball: ball, piece: piece)
            delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
            
        case "top":
            
            let startSide = "top"
            
            if let endSide = piece.side.top.exitSide {
                
                if piece.side.top.color != ball.onColor {
                    
                    delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                    break
                }
                
                if piece.shape == .cross {
                    
                    if check4CrossCrash(piece: piece, ball: ball, startSide: startSide) == true {
                        
                        delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                        
                        break
                        
                    } else {
 
                        let delayedTime = DispatchTime.now() + .milliseconds(Int(250))
                        
                        switchSwitches(piece: piece)
                        setPieceSides(piece: piece)
                        
                        DispatchQueue.main.asyncAfter(deadline: delayedTime) {

                            self.delegate?.replacePieceView(piece: piece)
                        }
                    }
                }
                
                if piece.shape == .doubleElbow || piece.shape == .elbow {
                    
                    let delayedTime = DispatchTime.now() + .milliseconds(Int(250))
                    
                    
                    switchSwitches(piece: piece)
                    setPieceSides(piece: piece)
                    
                    DispatchQueue.main.asyncAfter(deadline: delayedTime) {
                        
                        self.delegate?.replacePieceView(piece: piece)
                    }
                }
                
                if piece.shape == .colorChanger {
                    
                    ball.onColor = piece.side.bottom.color!
                }
                
                addToPiecesPassed(ball: ball, piece: piece)
                checkIfBallExited(ball: ball, endSide: endSide)
                
                if check4EndlessLoop(ball: ball) == true {
                    
                    removePiecesInPath(ball: ball)
                    check4Winner()
                    
                    self.delegate?.addSwipeGestureRecognizer(view: self.board.view)
                    
                    break
                    
                } else {
                    
                    delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
                }
                
            } else {
                
                delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                print("crashed into a wall, or no track in place")
                                
                
                break
            }
            
        case "bottom":
            
            let startSide = "bottom"
            
            if let endSide = piece.side.bottom.exitSide {
                
                if piece.side.bottom.color != ball.onColor {
                    
                    delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                    
                    return
                }
                
                if piece.shape == .cross {
                    
                    if check4CrossCrash(piece: piece, ball: ball, startSide: startSide) == true {
                        
                        delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                        
                        break
                        
                    } else {
                        
                        let delayedTime = DispatchTime.now() + .milliseconds(Int(250))
                        
                        switchSwitches(piece: piece)
                        setPieceSides(piece: piece)
                        
                        DispatchQueue.main.asyncAfter(deadline: delayedTime) {

                            self.delegate?.replacePieceView(piece: piece)
                        }
                    }
                }
                
                if piece.shape == .doubleElbow || piece.shape == .elbow {
                    
                    let delayedTime = DispatchTime.now() + .milliseconds(Int(250))
                    
                    switchSwitches(piece: piece)
                    setPieceSides(piece: piece)
                    
                    DispatchQueue.main.asyncAfter(deadline: delayedTime) {
                        
                        self.delegate?.replacePieceView(piece: piece)
                    }
                }
                
                if piece.shape == .colorChanger {
                    
                    ball.onColor = piece.side.top.color!
                }
                
                addToPiecesPassed(ball: ball, piece: piece)
                checkIfBallExited(ball: ball, endSide: endSide)
                
                if check4EndlessLoop(ball: ball) == true {
                    
                    removePiecesInPath(ball: ball)
                    check4Winner()

                    self.delegate?.addSwipeGestureRecognizer(view: self.board.view)
                    
                    break
                    
                } else {
                    
                    delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
                }

            } else {
                
                delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                
                print("crashed into a wall, or no track in place")
                
                break
            }
            
        case "left":
            
            let startSide = "left"
            
            if let endSide = piece.side.left.exitSide {
                
                if piece.side.left.color != ball.onColor {
                    
                    delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                    
                    break
                }
                
                if piece.shape == .cross {
                    
                    if check4CrossCrash(piece: piece, ball: ball, startSide: startSide) == true {
                        
                        delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                        
                        break
                        
                    } else {
                        
                        let delayedTime = DispatchTime.now() + .milliseconds(Int(250))
                        
                        switchSwitches(piece: piece)
                        setPieceSides(piece: piece)
                        
                        DispatchQueue.main.asyncAfter(deadline: delayedTime) {

                            self.delegate?.replacePieceView(piece: piece)
                        }
                    }
                }
                
                if piece.shape == .doubleElbow || piece.shape == .elbow {
                    
                    let delayedTime = DispatchTime.now() + .milliseconds(Int(250))
                    
                    switchSwitches(piece: piece)
                    setPieceSides(piece: piece)
                    
                    DispatchQueue.main.asyncAfter(deadline: delayedTime) {
                        
                        self.delegate?.replacePieceView(piece: piece)
                    }
                }
                
                if piece.shape == .colorChanger {
                    
                    ball.onColor = piece.side.right.color!
                }
                
                addToPiecesPassed(ball: ball, piece: piece)
                checkIfBallExited(ball: ball, endSide: endSide)
                
                if check4EndlessLoop(ball: ball) == true {
                    
                    removePiecesInPath(ball: ball)
                    check4Winner()
                    
                    self.delegate?.addSwipeGestureRecognizer(view: self.board.view)
                    
                    break
                    
                } else {
                    
                    delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
                }
                
            } else {
                
                delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                
                print("crashed into a wall, or no track in place")
                
                break
            }
            
        case "right":
            
            let startSide = "right"
            
            if let endSide = piece.side.right.exitSide {
                
                if piece.side.right.color != ball.onColor {
                    
                    delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                    
                    break
                }
                
                if piece.shape == .cross {
                    
                    if check4CrossCrash(piece: piece, ball: ball, startSide: startSide) == true {
                        
                        delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                        
                        break
                        
                    } else {
                        
                        let delayedTime = DispatchTime.now() + .milliseconds(Int(250))
                        
                        switchSwitches(piece: piece)
                        setPieceSides(piece: piece)
                        
                        DispatchQueue.main.asyncAfter(deadline: delayedTime) {

                            self.delegate?.replacePieceView(piece: piece)
                        }
                    }
                }
                
                if piece.shape == .doubleElbow || piece.shape == .elbow {
                    
                    let delayedTime = DispatchTime.now() + .milliseconds(Int(250))
                    
                    switchSwitches(piece: piece)
                    setPieceSides(piece: piece)
                    
                    DispatchQueue.main.asyncAfter(deadline: delayedTime) {
                        
                        self.delegate?.replacePieceView(piece: piece)
                    }
                }
                
                if piece.shape == .colorChanger {
                    
                    ball.onColor = piece.side.left.color!
                }
                
                addToPiecesPassed(ball: ball, piece: piece)
                checkIfBallExited(ball: ball, endSide: endSide)
                
                if check4EndlessLoop(ball: ball) == true {
                    
                    removePiecesInPath(ball: ball)
                    check4Winner()
                    
                    self.delegate?.addSwipeGestureRecognizer(view: self.board.view)
                    
                    break
                    
                } else {
                    
                    delegate?.moveBallView(ball: ball, piece: piece, startSide: startSide, endSide: endSide)
                }
                
            } else {
                                
                delegate?.runPopUpView(title: "YOU LOSE", message: "TRY AGAIN?")
                
                print("crashed into a wall, or no track in place")
                
                break
            }
        default:
            break
        }
        return
    }
    
    func checkIfBallExited(ball: Ball, endSide: String) {
               
        if endSide == "center" {
            
            CATransaction.begin()
            
            CATransaction.setCompletionBlock {
                
                self.delegate?.addSwipeGestureRecognizer(view: self.board.view)
                self.check4Winner()
                return
            }
            
            for piece in ball.piecesPassed {
                
                self.delegate?.removeView(view: piece.view)
                board.pieces.removeAll { (pieceX) -> Bool in
                    pieceX.indexes == piece.indexes
                }
            }
            
            self.board.balls.removeAll { (ballX) -> Bool in
                
                ballX.indexes == ball.indexes
            }
            
            self.delegate?.removeView(view: ball.view)
            CATransaction.commit()
        }
    }
    
    func check4Winner(){
        
        
        print(board.balls.isEmpty)
        
        if board.balls.isEmpty {
            
//            if gameIsLoading == false {
                
                self.delegate?.runPopUpView(title: "YOU WIN", message: "Great Job - Next Level?")
                self.gameOver = true
                return
                
//            } else {
//
//                gameIsLoading = false
//            }
            
        } else {
            
            return
        }
    }
    
    func handleTap(center: CGPoint) {
        
        moveStarted = true
        
        let x2 = Int(center.x)
        let y2 = Int(center.y)
        
        for piece in board.pieces {
            
            let x1 = Int(board.grid[piece.indexes]!.x)
            let y1 = Int(board.grid[piece.indexes]!.y)
            
            if CGPoint(x: x1, y: y1) == CGPoint(x: x2, y: y2) && piece.shape != .entrance && piece.shape != .exit {
                
                if board.moves > 0 || infiniteMoves == true {
                    
                    switchSwitches(piece: piece)
                    setPieceSides(piece: piece)
                    delegate?.replacePieceView(piece: piece)
                }
                
            } else if CGPoint(x: x1, y: y1) == CGPoint(x: x2, y: y2) && piece.shape == .entrance && piece.shape != .exit {
                
                moveStarted = false
                
                for ball in board.balls {
                    
                    if board.grid[ball.indexes] == center {
                        
                        moveBall(ball: ball, startSide: "unmoved")
                    }
                }
            }
        }
    }
    
    func switchCross(piece: Piece, ball: Ball) {
        
        piece.side.left.closing.isOpen = !piece.side.left.closing.isOpen
        piece.side.right.closing.isOpen = !piece.side.right.closing.isOpen
        piece.side.top.closing.isOpen = !piece.side.top.closing.isOpen
        piece.side.bottom.closing.isOpen = !piece.side.bottom.closing.isOpen
        
        if piece.currentSwitch == 1 {
            piece.currentSwitch = 2
        } else {
            piece.currentSwitch = 1
        }
        
        delegate?.replacePieceView(piece: piece)
    }
    
    func check4CrossCrash(piece: Piece, ball: Ball, startSide: String) -> Bool {
        
        //TODO: Move this to the Model
        
        var bool = false
        
        switch startSide {
        
        case "top":
            if piece.side.top.closing.isOpen == false {

                delegate?.crashBallViewIntoCross(piece: piece, ball: ball)
                bool = true
            }
        case "bottom":
            if piece.side.bottom.closing.isOpen == false {

                delegate?.crashBallViewIntoCross(piece: piece, ball: ball)
                bool = true
            }
        case "left":
            if piece.side.left.closing.isOpen == false {

                delegate?.crashBallViewIntoCross(piece: piece, ball: ball)
                bool = true
            }
        case "right":
            if piece.side.right.closing.isOpen == false {

                delegate?.crashBallViewIntoCross(piece: piece, ball: ball)
                bool = true
            }
        default:
            break
            
        }
        return bool
    }
    
    func switchPivot(piece: Piece, ball: Ball) {
        
        if piece.currentSwitch == 1 {
            piece.currentSwitch = 2
        } else {
            piece.currentSwitch = 1
        }
        
        setPieceSides(piece: piece)
        delegate?.replacePieceView(piece: piece)
    }
    
    func switchSwitches(piece: Piece) {

        if piece.isLocked || piece.doesPivot == false { return }
        
        if piece.shape != .entrance {
            
            updateMovesLeft()
        }
        
        if piece.currentSwitch != piece.switches {
            
            piece.currentSwitch += 1
            
        } else {
            
            piece.currentSwitch = 1
        }
    }
 
    func updateUserDefaults() {
        
        defaults.set(level.number, forKey: "level")
        
        // Checking to make sure that the highest level hasnt been saved to user defaults and then saving it there
        if self.level.number > self.defaults.integer(forKey: "highestLevel") {
            
            self.defaults.set(self.level.number, forKey: "highestLevel")
        }
    }
    
    func resetGame() {
        
        
        updateUserDefaults()
                        
        for piece in board.pieces {
            
//            var counter = 0

            delegate?.clearPiecesAnimation(view: piece.view)
//            board.pieces.remove(at: counter)
//            counter += 1
        }
        
        board.pieces.removeAll()
        
        for ball in board.balls {
            
            ball.piecesPassed = [Piece]()
            delegate?.clearPiecesAnimation(view: ball.view)
        }
        
        
        
        for ball in board.balls {
            
            delegate?.removeView(view: ball.view)
        }
                
        board.balls.removeAll()
        gameOver = false
    }
}
