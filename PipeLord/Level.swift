//
//  Level.swift
//  PipeLord
//
//  Created by Jeffery Widroff on 06/04/2022.
//

import Foundation
import UIKit


// Introduce to ice
// Introduce to no walls
// Introduce to holes
// Introduce to switches
// Introduce to multiColor switches
// Introduce to multiple colors
// Introduce to pieceMaker
// Introduce to colorChanger
// Introduce to loops
// Introduce to crosses
// Introduce to multi color crosses
// Introduce to pieces switching after balls move
// Introduce to multiple balls
// Introduce to pieces being locked
// Introduce to pieces that do nothing (walls that dont move)




class Level {
    
    var number = 12
//    var highestLevel = 1

    var board = Board()
    
}

class LevelModel {
    
    let board = Board()
    
    let levelNames = [
                      "basic",
                      "walls intro",
                      "new connection",
                      "intro to lock",
                      "no lock",
                      "look away",
                      "piecey",
                      "try to guess",
                      "lucky guess",
                      "infinite",
                      "test10",
                      "Around and back",
                      "you tell me",
                      "test1",
                      "Sharp Elbow", //DIFFICULT
                      "intro to double elbow",
                      "test2",
                      "everything",
                      "Around and back",
                      "test4",
                      "test3",
       
                      "test5",
                      "test6",
                      "test7",
                      "test8",
                      "test9",
                      
                      ]
        
    func returnBoard(levelNumber: Int) -> Board {
        
        
        let levelName = levelNames[levelNumber]
        
        
        switch levelName {
        
//        case "intro":
//
//            board.randomPieceColors = [UIColor.red]
//            board.randomPieceShapes = [.diagElbow]
//            board.heightSpaces = 34
//            board.widthSpaces = 17
//            addBorderAroundBoardOf(.wall, exceptionIndexes: [])
//
//            let entrance = Piece(indexes: Indexes(x: 1, y: 1), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "bottom", doesPivot: nil)
//            board.pieces.append(entrance)
//
//
//            let exit = Piece(indexes: Indexes(x: board.widthSpaces - 2, y: board.heightSpaces - 2), shape: .exit, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "top", doesPivot: nil)
//            board.pieces.append(exit)
            
            
        case "loading":
            
            board.moves = 1
            
            board.heightSpaces = 12
            board.widthSpaces = 7
            
            let piece1 = Piece(indexes: Indexes(x: 1, y: 0), shape: .entrance, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: "right", doesPivot: false)
            board.pieces.append(piece1)

            let piece2 = Piece(indexes: Indexes(x: 2, y: 0), shape: .stick, colors: [UIColor.red], version: 3, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
            board.pieces.append(piece2)
            
            let piece3 = Piece(indexes: Indexes(x: 3, y: 0), shape: .doubleElbow, colors: [UIColor.red], version: 3, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
            board.pieces.append(piece3)
            
            let piece4 = Piece(indexes: Indexes(x: 4, y: 0), shape: .stick, colors: [UIColor.red], version: 3, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
            board.pieces.append(piece4)
            
            let piece5 = Piece(indexes: Indexes(x: 5, y: 0), shape: .elbow, colors: [UIColor.red], version: 2, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
            board.pieces.append(piece5)
            
            let piece6 = Piece(indexes: Indexes(x: 5, y: 1), shape: .stick, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
            board.pieces.append(piece6)
            
            let piece7 = Piece(indexes: Indexes(x: 5, y: 2), shape: .elbow, colors: [UIColor.red], version: 2, currentSwitch: 2, isLocked: false, opening: nil, doesPivot: false)
            board.pieces.append(piece7)

            let piece8 = Piece(indexes: Indexes(x: 4, y: 2), shape: .stick, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
            board.pieces.append(piece8)
            
            let piece9 = Piece(indexes: Indexes(x: 3, y: 2), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
            board.pieces.append(piece9)
            
            let piece10 = Piece(indexes: Indexes(x: 3, y: 1), shape: .stick, colors: [UIColor.red], version: 4, currentSwitch: 2, isLocked: false, opening: nil, doesPivot: false)
            board.pieces.append(piece10)
            
//            let piece11 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
//            board.pieces.append(piece11)
//
//            let piece12 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
//            board.pieces.append(piece12)
//
//            let piece13 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
//            board.pieces.append(piece13)
//
//            let piece14 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
//            board.pieces.append(piece14)
//
//            let piece15 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
//            board.pieces.append(piece15)
//
//            let piece16 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
//            board.pieces.append(piece16)
//
//            let piece17 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
//            board.pieces.append(piece17)
//
//            let piece18 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
//            board.pieces.append(piece18)
//
//            let piece19 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
//            board.pieces.append(piece19)
//
//            let piece20 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
//            board.pieces.append(piece20)
//
//            let piece21 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
//            board.pieces.append(piece21)
//
//            let piece22 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
//            board.pieces.append(piece22)
//
//            let piece23 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
//            board.pieces.append(piece23)
//
//            let piece24 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
//            board.pieces.append(piece24)
//
//            let piece25 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
//            board.pieces.append(piece25)
//
//            let piece26 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
//            board.pieces.append(piece26)
//
//            let piece27 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
//            board.pieces.append(piece27)
//
//            let piece28 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
//            board.pieces.append(piece28)
//
//            let piece29 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
//            board.pieces.append(piece29)
//
//            let piece30 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
//            board.pieces.append(piece30)
//
//            let piece31 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
//            board.pieces.append(piece31)
//
//            let piece32 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
//            board.pieces.append(piece32)
//
//            let piece33 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
//            board.pieces.append(piece33)
//
//            let piece34 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
//            board.pieces.append(piece34)
//
//            let piece35 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
//            board.pieces.append(piece35)
//
//            let piece36 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
//            board.pieces.append(piece36)
//
            
            
            
        case "basic": //Moving the entrance and exits

            board.colorTheme.gradientBackgroundColor = [UIColor.yellow, UIColor.cyan]
            
            
            board.randomPieceColors = [UIColor.red]
            board.randomPieceShapes = [.diagElbow]
            board.heightSpaces = 8
            board.widthSpaces = 4
            addBorderAroundBoardOf(.wall, exceptionIndexes: [])

            let entrance = Piece(indexes: Indexes(x: 1, y: 1), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "bottom", doesPivot: nil)
            board.pieces.append(entrance)


            let exit = Piece(indexes: Indexes(x: board.widthSpaces - 2, y: board.heightSpaces - 2), shape: .exit, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "top", doesPivot: nil)
            board.pieces.append(exit)

        case "walls intro": //Moving the entrance and exits with walls in the way

            
            board.moves = 10

            
            board.colorTheme.gradientBackgroundColor = [UIColor.red, UIColor.green]
            
            
            board.randomPieceColors = [UIColor.red]
            board.randomPieceShapes = [.diagElbow]//, .cross]//, .stick, .elbow]
//            board.amountOfRandomPieces = 20
//            board.iceLocations = [Indexes(x: 3, y: 7), Indexes(x: 3, y: 9)]
//            board.holeLocations = [Indexes(x: 0, y: 1)]

            board.heightSpaces = 8

            board.widthSpaces = 4

//            board.wallLocations = [Indexes(x: -1, y: -1)]

            addBorderAroundBoardOf(.wall, exceptionIndexes: [])

            let entrance = Piece(indexes: Indexes(x: 1, y: 1), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "right", doesPivot: nil)
            board.pieces.append(entrance)


            let exit = Piece(indexes: Indexes(x: board.widthSpaces - 2, y: board.heightSpaces - 2), shape: .exit, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "left", doesPivot: nil)
            board.pieces.append(exit)


            setupRowOrColumnOf(.wall, rowOrColumn: "row", index: 2, exception: [2], pieceMakerOpening: "")

            setupRowOrColumnOf(.wall, rowOrColumn: "row", index: 4, exception: [1], pieceMakerOpening: "")

            setupRowOrColumnOf(.wall, rowOrColumn: "row", index: 5, exception: [1], pieceMakerOpening: "")

//            let wall1 = Piece(indexes: Indexes(x: 3, y: 4), shape: .wall, colors: [.darkGray], version: 1, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: nil)
//            board.pieces.append(wall1)
//
//
//            let wall2 = Piece(indexes: Indexes(x: 3, y: 4), shape: .wall, colors: [.darkGray], version: 1, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: nil)
//            board.pieces.append(wall2)


        case "new connection": //Added new connection piece that is needed to move ball

            board.randomPieceColors = [UIColor.red]
            board.randomPieceShapes = [.diagElbow]
            board.heightSpaces = 8
            board.widthSpaces = 4

            addBorderAroundBoardOf(.wall, exceptionIndexes: [])

            let entrance = Piece(indexes: Indexes(x: 1, y: 1), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "bottom", doesPivot: nil)
            board.pieces.append(entrance)


            let exit = Piece(indexes: Indexes(x: board.widthSpaces - 2, y: board.heightSpaces - 2), shape: .exit, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "left", doesPivot: nil)
            board.pieces.append(exit)

            let piece = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
            board.pieces.append(piece)


            setupRowOrColumnOf(.wall, rowOrColumn: "row", index: 2, exception: [2], pieceMakerOpening: "")

            setupRowOrColumnOf(.wall, rowOrColumn: "row", index: 4, exception: [1], pieceMakerOpening: "")

            setupRowOrColumnOf(.wall, rowOrColumn: "row", index: 5, exception: [1], pieceMakerOpening: "")


        case "intro to lock": //Added another connection piece and introduced pieces that are locked in place

            board.randomPieceColors = [UIColor.red]
            board.randomPieceShapes = [.diagElbow]
            board.heightSpaces = 8
            board.widthSpaces = 4

            addBorderAroundBoardOf(.wall, exceptionIndexes: [])

            let entrance = Piece(indexes: Indexes(x: 1, y: 1), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "left", doesPivot: nil)
            board.pieces.append(entrance)


            let exit = Piece(indexes: Indexes(x: board.widthSpaces - 2, y: board.heightSpaces - 2), shape: .exit, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: true, opening: "left", doesPivot: nil)
            board.pieces.append(exit)

            let piece1 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 3, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
            board.pieces.append(piece1)

            let piece2 = Piece(indexes: Indexes(x: 2, y: 2), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
            board.pieces.append(piece2)


            setupRowOrColumnOf(.wall, rowOrColumn: "row", index: 3, exception: [2], pieceMakerOpening: "")


        case "no lock": // Same level as the last one except no pieces were stuck in place which made it harder

//            board.randomPieceColors = [UIColor.red]
//            board.randomPieceShapes = [.diagElbow]
            board.heightSpaces = 8
            board.widthSpaces = 4

            addBorderAroundBoardOf(.wall, exceptionIndexes: [])

            let entrance = Piece(indexes: Indexes(x: 1, y: 1), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "left", doesPivot: nil)
            board.pieces.append(entrance)


            let exit = Piece(indexes: Indexes(x: board.widthSpaces - 2, y: board.heightSpaces - 2), shape: .exit, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "left", doesPivot: nil)
            board.pieces.append(exit)

            let piece1 = Piece(indexes: Indexes(x: 2, y: 1), shape: .elbow, colors: [UIColor.red], version: 3, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
            board.pieces.append(piece1)

            let piece2 = Piece(indexes: Indexes(x: 2, y: 2), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
            board.pieces.append(piece2)

//            let piece3 = Piece(indexes: Indexes(x: 2, y: 3), shape: .stick, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
//            board.pieces.append(piece3)


            setupRowOrColumnOf(.wall, rowOrColumn: "row", index: 3, exception: [2], pieceMakerOpening: "")


        case "look away": //5


            board.heightSpaces = 12
            board.widthSpaces = 6
            addBorderAroundBoardOf(.wall, exceptionIndexes: [])

            let entrance = Piece(indexes: Indexes(x: 1, y: 1), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "right", doesPivot: nil)
            board.pieces.append(entrance)


            let exit = Piece(indexes: Indexes(x: board.widthSpaces - 2, y: board.heightSpaces - 2), shape: .exit, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "bottom", doesPivot: nil)
            board.pieces.append(exit)


            let piece1 = Piece(indexes: Indexes(x: 3, y: 4), shape: .elbow, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: false)
            board.pieces.append(piece1)

            let piece2 = Piece(indexes: Indexes(x: 3, y: 5), shape: .wall, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: false)
            board.pieces.append(piece2)

            let piece3 = Piece(indexes: Indexes(x: 2, y: 4), shape: .elbow, colors: [UIColor.red], version: 3, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: false)
            board.pieces.append(piece3)

            let piece4 = Piece(indexes: Indexes(x: 2, y: 5), shape: .elbow, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: false)
            board.pieces.append(piece4)



        case "piecey": //6

            board.heightSpaces = 12
            board.widthSpaces = 6
            addBorderAroundBoardOf(.wall, exceptionIndexes: [])

            let entrance = Piece(indexes: Indexes(x: 1, y: 1), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "right", doesPivot: nil)
            board.pieces.append(entrance)


            let exit = Piece(indexes: Indexes(x: board.widthSpaces - 2, y: board.heightSpaces - 2), shape: .exit, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "top", doesPivot: nil)
            board.pieces.append(exit)


            let piece1 = Piece(indexes: Indexes(x: 3, y: 4), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: false)
            board.pieces.append(piece1)

            let piece2 = Piece(indexes: Indexes(x: 3, y: 5), shape: .elbow, colors: [UIColor.red], version: 3, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: false)
            board.pieces.append(piece2)

            let piece3 = Piece(indexes: Indexes(x: 2, y: 4), shape: .elbow, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: false)
            board.pieces.append(piece3)

            let piece4 = Piece(indexes: Indexes(x: 2, y: 5), shape: .elbow, colors: [UIColor.red], version: 2, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: false)
            board.pieces.append(piece4)


            print()





        case "try to guess": //7


            board.heightSpaces = 12
            board.widthSpaces = 6
            addBorderAroundBoardOf(.wall, exceptionIndexes: [])

            let entrance = Piece(indexes: Indexes(x: 1, y: 1), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "right", doesPivot: nil)
            board.pieces.append(entrance)


            let exit = Piece(indexes: Indexes(x: board.widthSpaces - 2, y: board.heightSpaces - 2), shape: .exit, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "top", doesPivot: nil)
            board.pieces.append(exit)


            let piece1 = Piece(indexes: Indexes(x: 2, y: 4), shape: .stick, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: false)
            board.pieces.append(piece1)

            let piece2 = Piece(indexes: Indexes(x: 3, y: 5), shape: .stick, colors: [UIColor.red], version: 2, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: false)
            board.pieces.append(piece2)

            let piece3 = Piece(indexes: Indexes(x: 3, y: 8), shape: .elbow, colors: [UIColor.red], version: 2, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
            board.pieces.append(piece3)

        case "lucky guess"://8

            board.heightSpaces = 12
            board.widthSpaces = 6
//
//            let entrance = Piece(indexes: Indexes(x: 1, y: 1), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "top", doesPivot: nil)
//            board.pieces.append(entrance)
//
//
//            let exit = Piece(indexes: Indexes(x: board.widthSpaces - 2, y: board.heightSpaces - 2), shape: .exit, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "left", doesPivot: nil)
//            board.pieces.append(exit)
//

            let piece1 = Piece(indexes: Indexes(x: 2, y: 5), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: false)
            board.pieces.append(piece1)

            let piece2 = Piece(indexes: Indexes(x: 2, y: 4), shape: .elbow, colors: [UIColor.red], version: 3, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: false)
            board.pieces.append(piece2)

            let piece3 = Piece(indexes: Indexes(x: 3, y: 4), shape: .elbow, colors: [UIColor.red], version: 2, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: false)
            board.pieces.append(piece3)

            let entrance = Piece(indexes: Indexes(x: 3, y: 6), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "top", doesPivot: nil)
            board.pieces.append(entrance)


            let exit = Piece(indexes: Indexes(x: 4, y: 5), shape: .exit, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "left", doesPivot: nil)
            board.pieces.append(exit)

            let piece4 = Piece(indexes: Indexes(x: 3, y: 5), shape: .cross, colors: [UIColor.red, UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(piece4)




            addBorderAroundBoardOf(.wall, exceptionIndexes: [])


        case "infinite": //9


            board.moves = 5

            board.heightSpaces = 12
            board.widthSpaces = 6

            let entrance = Piece(indexes: Indexes(x: 2, y: 5), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "left", doesPivot: nil)
            board.pieces.append(entrance)


            let exit = Piece(indexes: Indexes(x: 2, y: 6), shape: .exit, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "left", doesPivot: nil)
            board.pieces.append(exit)


            let piece1 = Piece(indexes: Indexes(x: 0, y: 5), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: false)
            board.pieces.append(piece1)

            let piece2 = Piece(indexes: Indexes(x: 0, y: 4), shape: .elbow, colors: [UIColor.red], version: 3, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: false)
            board.pieces.append(piece2)

            let piece3 = Piece(indexes: Indexes(x: 1, y: 4), shape: .elbow, colors: [UIColor.red], version: 2, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: false)
            board.pieces.append(piece3)

            let piece4 = Piece(indexes: Indexes(x: 1, y: 6), shape: .cross, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(piece4)

            let piece5 = Piece(indexes: Indexes(x: 0, y: 6), shape: .elbow, colors: [UIColor.red], version: 3, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: false)
            board.pieces.append(piece5)

            let piece6 = Piece(indexes: Indexes(x: 0, y: 7), shape: .elbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: false)
            board.pieces.append(piece6)

            let piece7 = Piece(indexes: Indexes(x: 1, y: 7), shape: .elbow, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: false)
            board.pieces.append(piece7)

            let piece8 = Piece(indexes: Indexes(x: 1, y: 5), shape: .cross, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(piece8)


            addBorderAroundBoardOf(.wall, exceptionIndexes: [])


        case "you tell me": //11


            board.heightSpaces = 10
            board.widthSpaces = 5
            board.randomPieceColors = [.red, .blue]
            board.randomPieceShapes = [.stick, .colorChanger]//.cross, .elbow, .stick, .diagElbow]
            board.amountOfRandomPieces = 16


            let entrance1 = Piece(indexes: Indexes(x: 4, y: 3), shape: .exit, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: true, opening: "left", doesPivot: nil)
            board.pieces.append(entrance1)


            let exit1 = Piece(indexes: Indexes(x: 4, y: 5), shape: .exit, colors: [UIColor.blue], version: 1, currentSwitch: 1, isLocked: true, opening: "left", doesPivot: nil)
            board.pieces.append(exit1)


            let entrance2 = Piece(indexes: Indexes(x: 0, y: 3), shape: .entrance, colors: [UIColor.blue], version: 1, currentSwitch: 1, isLocked: true, opening: "right", doesPivot: nil)
            board.pieces.append(entrance2)


            let exit2 = Piece(indexes: Indexes(x: 0, y: 5), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: true, opening: "right", doesPivot: nil)
            board.pieces.append(exit2)



            addBorderAroundBoardOf(.wall, exceptionIndexes: [])


            print()



        case "Sharp Elbow":
            
            
            
            board.colorTheme.gradientBackgroundColor = [UIColor.cyan, UIColor.green]
            
            board.moves = 14
            board.randomPieceColors = [UIColor.red]
            board.randomPieceShapes = [.diagElbow]
            board.heightSpaces = 10
            board.widthSpaces = 5
            addBorderAroundBoardOf(.wall, exceptionIndexes: [])

            let entrance = Piece(indexes: Indexes(x: 1, y: 1), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "bottom", doesPivot: nil)
            board.pieces.append(entrance)


            let exit = Piece(indexes: Indexes(x: board.widthSpaces - 2, y: board.heightSpaces - 2), shape: .exit, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "left", doesPivot: nil)
            board.pieces.append(exit)


            let piece1 = Piece(indexes: Indexes(x: 2, y: 3), shape: .elbow, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)

            board.pieces.append(piece1)

            let wall1 = Piece(indexes: Indexes(x: 2, y: 4), shape: .wall, colors: [UIColor.black], version: 1, currentSwitch: 2, isLocked: true, opening: nil, doesPivot: false)
            
            board.pieces.append(wall1)

            let wall2 = Piece(indexes: Indexes(x: 2, y: 8), shape: .wall, colors: [UIColor.black], version: 1, currentSwitch: 2, isLocked: true, opening: nil, doesPivot: false)
            
            board.pieces.append(wall2)
            


            setupRowOrColumnOf(.wall, rowOrColumn: "row", index: 2, exception: [2], pieceMakerOpening: nil)
            setupRowOrColumnOf(.wall, rowOrColumn: "row", index: 6, exception: [2], pieceMakerOpening: nil)

            
        case "intro to double elbow":
            
            board.colorTheme.gradientBackgroundColor = [UIColor.systemPink, UIColor.green]
            
//            board.moves = 14
            board.randomPieceColors = [UIColor.red]
            board.randomPieceShapes = [.diagElbow]
            board.heightSpaces = 12
            board.widthSpaces = 6
            addBorderAroundBoardOf(.wall, exceptionIndexes: [Indexes(x: 5, y: 5),Indexes(x: 5, y: 4)])

            let entrance = Piece(indexes: Indexes(x: 1, y: 2), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "top", doesPivot: nil)
            board.pieces.append(entrance)
            
            let entrance2 = Piece(indexes: Indexes(x: 4, y: 2), shape: .entrance, colors: [UIColor.blue], version: 1, currentSwitch: 1, isLocked: false, opening: "left", doesPivot: nil)
            board.pieces.append(entrance2)


//            let exit = Piece(indexes: Indexes(x: board.widthSpaces - 2, y: board.heightSpaces - 3), shape: .exit, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "left", doesPivot: nil)
//            board.pieces.append(exit)

            
            let exit2 = Piece(indexes: Indexes(x: 2, y: 8), shape: .exit, colors: [UIColor.blue], version: 1, currentSwitch: 1, isLocked: true, opening: "top", doesPivot: nil)
            board.pieces.append(exit2)

            let piece1 = Piece(indexes: Indexes(x: 4, y: 4), shape: .elbow, colors: [UIColor.red], version: 2, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: true)

            board.pieces.append(piece1)
            
            let piece2 = Piece(indexes: Indexes(x: 4, y: 5), shape: .elbow, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: true)

            board.pieces.append(piece2)
            
            
            let piece3 = Piece(indexes: Indexes(x: 3, y: 4), shape: .elbow, colors: [UIColor.red], version: 3, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: true)

            board.pieces.append(piece3)
            
            let piece4 = Piece(indexes: Indexes(x: board.widthSpaces - 2, y: board.heightSpaces - 3), shape: .doubleElbow, colors: [UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)

            board.pieces.append(piece4)
            
            let piece5 = Piece(indexes: Indexes(x: 3, y: 5), shape: .elbow, colors: [UIColor.blue], version: 4, currentSwitch: 2, isLocked: false, opening: nil, doesPivot: false)

            board.pieces.append(piece5)
            
            
            

//            let wall1 = Piece(indexes: Indexes(x: 2, y: 4), shape: .wall, colors: [UIColor.black], version: 1, currentSwitch: 2, isLocked: true, opening: nil, doesPivot: false)
//
//            board.pieces.append(wall1)

//            let wall2 = Piece(indexes: Indexes(x: 2, y: 8), shape: .wall, colors: [UIColor.black], version: 1, currentSwitch: 2, isLocked: true, opening: nil, doesPivot: false)
//
//            board.pieces.append(wall2)
            


            setupRowOrColumnOf(.wall, rowOrColumn: "row", index: 1, exception: [], pieceMakerOpening: nil)
            setupRowOrColumnOf(.wall, rowOrColumn: "row", index: 8, exception: [2], pieceMakerOpening: nil)

            
            

        case "test1":
            
            board.colorTheme.gradientBackgroundColor = [UIColor.red, UIColor.yellow]

            board.randomPieceColors = [UIColor.blue, UIColor.blue, UIColor.blue]
            board.randomPieceShapes = [.diagElbow]//, .cross, .doubleElbow]
            board.amountOfRandomPieces = 20
//            board.iceLocations = [Indexes(x: 3, y: 7), Indexes(x: 3, y: 9)]
//            board.holeLocations = [Indexes(x: 0, y: 1)]

            board.heightSpaces = 10

            board.widthSpaces = 5

//            board.wallLocations = [Indexes(x: -1, y: -1)]

            addBorderAroundBoardOf(.wall, exceptionIndexes: [])

            let entrance = Piece(indexes: Indexes(x: 1, y: 2), shape: .entrance, colors: [UIColor.blue], version: 1, currentSwitch: 1, isLocked: true, opening: "right", doesPivot: nil)
            board.pieces.append(entrance)


            let exit = Piece(indexes: Indexes(x: board.widthSpaces - 2, y: board.heightSpaces - 2), shape: .exit, colors: [UIColor.blue], version: 1, currentSwitch: 1, isLocked: true, opening: "top", doesPivot: nil)
            board.pieces.append(exit)




        case "test2":

            board.colorTheme.gradientBackgroundColor = [UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0), UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.8)]
            
            
            board.randomPieceColors = [UIColor.red, UIColor.blue]
            board.randomPieceShapes = [.diagElbow, .cross, .stick, .elbow]
            board.amountOfRandomPieces = 0
            board.iceLocations = [Indexes(x: 3, y: 7), Indexes(x: 3, y: 9)]
            board.holeLocations = [Indexes(x: 0, y: 1), Indexes(x: 5, y: 1)]

            board.heightSpaces = 14
            board.widthSpaces = 7

            addBorderAroundBoardOf(.wall, exceptionIndexes: [Indexes(x: 0, y: 1)])


//            setupRowOrColumnOf(.wall, rowOrColumn: "row", index: 0, exception: [0], pieceMakerOpening: nil)
//            setupRowOrColumnOf(.wall, rowOrColumn: "row", index: board.heightSpaces - 1, exception: [], pieceMakerOpening: nil)
//            setupRowOrColumnOf(.wall, rowOrColumn: "column", index: 0, exception: [0], pieceMakerOpening: nil)
//            setupRowOrColumnOf(.wall, rowOrColumn: "column", index: board.widthSpaces - 1, exception: [3], pieceMakerOpening: nil)


//            setupRowOrColumnOf(.pieceMaker, rowOrColumn: "row", index: 0, exception: [], pieceMakerOpening: "bottom")
//            setupRowOrColumnOf(.pieceMaker, rowOrColumn: "row", index: board.heightSpaces - 1, exception: [2], pieceMakerOpening: "top")
//            setupRowOrColumnOf(.pieceMaker, rowOrColumn: "column", index: 0, exception: [], pieceMakerOpening: "left")
//            setupRowOrColumnOf(.pieceMaker, rowOrColumn: "column", index: board.widthSpaces - 1, exception: [3], pieceMakerOpening: "right")
//

            let entrance = Piece(indexes: Indexes(x: 1, y: 2), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "right", doesPivot: nil)
            board.pieces.append(entrance)


//            let exit = Piece(indexes: Indexes(x: board.widthSpaces - 2, y: board.heightSpaces - 2), shape: .exit, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: true, opening: "top", doesPivot: nil)
//            board.pieces.append(exit)


            let exit = Piece(indexes: Indexes(x: 2, y: 4), shape: .exit, colors: [UIColor.blue], version: 1, currentSwitch: 1, isLocked: true, opening: "top", doesPivot: nil)
            board.pieces.append(exit)

            let piece = Piece(indexes: Indexes(x: 2, y: 2), shape: .diagElbow, colors: [UIColor.blue, UIColor.red], version: 1, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: nil)
            board.pieces.append(piece)

//            let wall = Piece(indexes: Indexes(x: 3, y: 4), shape: .wall, colors: [.darkGray], version: 1, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: nil)
//            board.pieces.append(wall)

            let colorChanger = Piece(indexes: Indexes(x: 2, y: 3), shape: .colorChanger, colors: [UIColor.red, UIColor.blue], version: 2, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: nil)
            board.pieces.append(colorChanger)

            let pieceMaker = Piece(indexes: Indexes(x: 1, y: 4), shape: .pieceMaker, colors: [.black], version: 1, currentSwitch: 1, isLocked: true, opening: "bottom", doesPivot: nil)
            board.pieces.append(pieceMaker)

//            setUpLevelDefaults()



        case "test3":

            board.colorTheme.gradientBackgroundColor = [UIColor.purple, UIColor.blue]

            board.randomPieceShapes = [.elbow]//, .cross, .stick, .elbow]
            board.amountOfRandomPieces = 8
            board.heightSpaces = 10
            board.widthSpaces = 5
            addBorderAroundBoardOf(.wall, exceptionIndexes: [Indexes(x: 0, y: 1)])

            let entrance = Piece(indexes: Indexes(x: 1, y: 2), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: true, opening: "right", doesPivot: nil)
            board.pieces.append(entrance)


            let exit = Piece(indexes: Indexes(x: board.widthSpaces - 2, y: board.heightSpaces - 2), shape: .exit, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: true, opening: "top", doesPivot: nil)
            board.pieces.append(exit)




           print()


        case "test4":


            board.heightSpaces = 12
            board.widthSpaces = 6
            addBorderAroundBoardOf(.wall, exceptionIndexes: [])

            let entrance1 = Piece(indexes: Indexes(x: 2, y: 5), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: true, opening: "right", doesPivot: nil)
            board.pieces.append(entrance1)

            let entrance2 = Piece(indexes: Indexes(x: 2, y: 4), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: true, opening: "right", doesPivot: nil)
            board.pieces.append(entrance2)



            let exit1 = Piece(indexes: Indexes(x: 4, y: 5), shape: .exit, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: true, opening: "left", doesPivot: nil)
            board.pieces.append(exit1)

            let exit2 = Piece(indexes: Indexes(x: 4, y: 4), shape: .exit, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: true, opening: "left", doesPivot: nil)
            board.pieces.append(exit2)


            let piece1 = Piece(indexes: Indexes(x: 3, y: 5), shape: .cross, colors: [UIColor.red, UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(piece1)

            let piece2 = Piece(indexes: Indexes(x: 3, y: 4), shape: .cross, colors: [UIColor.red, UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(piece2)
//


        case "test5":


            board.heightSpaces = 12
            board.widthSpaces = 6

            board.amountOfRandomPieces = 20
            
            board.randomPieceColors = [UIColor.red, UIColor.red, UIColor.red]

            board.randomPieceShapes = [.doubleElbow, .cross]

            let entrance1 = Piece(indexes: Indexes(x: 4, y: 5), shape: .entrance, colors: [UIColor.blue], version: 1, currentSwitch: 1, isLocked: false, opening: "left", doesPivot: nil)
            board.pieces.append(entrance1)

            let entrance2 = Piece(indexes: Indexes(x: 2, y: 5), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "right", doesPivot: nil)
            board.pieces.append(entrance2)

            let entrance3 = Piece(indexes: Indexes(x: 3, y: 4), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "bottom", doesPivot: nil)
            board.pieces.append(entrance3)

            let entrance4 = Piece(indexes: Indexes(x: 3, y: 6), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "top", doesPivot: nil)
            board.pieces.append(entrance4)


            let piece = Piece(indexes: Indexes(x: 3, y: 5), shape: .cross, colors: [UIColor.red, UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(piece)

            let testPiece = Piece(indexes: Indexes(x: 4, y: 7), shape: .doubleElbow, colors: [UIColor.red, UIColor.blue], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(testPiece)


            addBorderAroundBoardOf(.wall, exceptionIndexes: [])

            
        case "test6":


            board.heightSpaces = 14
            board.widthSpaces = 7

            board.amountOfRandomPieces = 30

            board.randomPieceColors = [UIColor.red, UIColor.red, UIColor.red]

            board.randomPieceShapes = [.doubleElbow]

            let entrance1 = Piece(indexes: Indexes(x: 4, y: 5), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "right", doesPivot: nil)
            board.pieces.append(entrance1)

//            let piece1 = Piece(indexes: Indexes(x: 5, y: 5), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 2, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
//            board.pieces.append(piece1)
            
            let entrance2 = Piece(indexes: Indexes(x: 2, y: 5), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "left", doesPivot: nil)
            board.pieces.append(entrance2)
            
//            let piece2 = Piece(indexes: Indexes(x: 1, y: 5), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
//            board.pieces.append(piece2)

            let entrance3 = Piece(indexes: Indexes(x: 3, y: 4), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "top", doesPivot: nil)
            board.pieces.append(entrance3)

//            let piece3 = Piece(indexes: Indexes(x: 3, y: 3), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 3, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
//            board.pieces.append(piece3)

            
            
            let entrance4 = Piece(indexes: Indexes(x: 3, y: 6), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "bottom", doesPivot: nil)
            board.pieces.append(entrance4)


           

            

           
//            let piece4 = Piece(indexes: Indexes(x: 3, y: 7), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
//            board.pieces.append(piece4)
//
            
            
            
            addBorderAroundBoardOf(.wall, exceptionIndexes: [])


        case "test7":

            print("TEST 7")

            board.heightSpaces = 12
            board.widthSpaces = 6

            board.amountOfRandomPieces = 0

            board.randomPieceColors = [UIColor.red, UIColor.red, UIColor.red]

            board.randomPieceShapes = [.doubleElbow]//, .cross, .diagElbow, .elbow]

            let entrance = Piece(indexes: Indexes(x: 2, y: 5), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "right", doesPivot: nil)
            board.pieces.append(entrance)
            
            let doubleElbow1 = Piece(indexes: Indexes(x: 3, y: 5), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 3, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(doubleElbow1)

            let doubleElbow2 = Piece(indexes: Indexes(x: 4, y: 5), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 2, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(doubleElbow2)
            
            let doubleElbow3 = Piece(indexes: Indexes(x: 3, y: 7), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(doubleElbow3)
            
            let doubleElbow4 = Piece(indexes: Indexes(x: 4, y: 7), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(doubleElbow4)
            
            let stick1 = Piece(indexes: Indexes(x: 3, y: 6), shape: .stick, colors: [UIColor.red, UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(stick1)
            
            let stick2 = Piece(indexes: Indexes(x: 4, y: 6), shape: .stick, colors: [UIColor.red, UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(stick2)
            
            

//            let piece1 = Piece(indexes: Indexes(x: 5, y: 5), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 2, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
//            board.pieces.append(piece1)
            
//            let entrance2 = Piece(indexes: Indexes(x: 2, y: 5), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "left", doesPivot: nil)
//            board.pieces.append(entrance2)
            
//            let piece2 = Piece(indexes: Indexes(x: 1, y: 5), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
//            board.pieces.append(piece2)

//            let entrance3 = Piece(indexes: Indexes(x: 3, y: 4), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "top", doesPivot: nil)
//            board.pieces.append(entrance3)

//            let piece3 = Piece(indexes: Indexes(x: 3, y: 3), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 3, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
//            board.pieces.append(piece3)

            
            
//            let entrance4 = Piece(indexes: Indexes(x: 3, y: 6), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "bottom", doesPivot: nil)
//            board.pieces.append(entrance4)


           

            

           
//            let piece4 = Piece(indexes: Indexes(x: 3, y: 7), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
//            board.pieces.append(piece4)
//
            
            
            
            addBorderAroundBoardOf(.wall, exceptionIndexes: [])


            
        case "test8":


            board.heightSpaces = 12
            board.widthSpaces = 6

            let entrance1 = Piece(indexes: Indexes(x: 3, y: 5), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "bottom", doesPivot: nil)
            board.pieces.append(entrance1)

            let piece1 = Piece(indexes: Indexes(x: 4, y: 5), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 2, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(piece1)
            
            let piece2 = Piece(indexes: Indexes(x: 3, y: 6), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(piece2)

            let piece3 = Piece(indexes: Indexes(x: 4, y: 6), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 2, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(piece3)

           
            let piece4 = Piece(indexes: Indexes(x: 3, y: 7), shape: .stick, colors: [UIColor.red, UIColor.red], version: 2, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(piece4)
//
            let piece5 = Piece(indexes: Indexes(x: 4, y: 7), shape: .stick, colors: [UIColor.red, UIColor.red], version: 2, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(piece5)
            
            let piece6 = Piece(indexes: Indexes(x: 3, y: 8), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(piece6)
            
            let piece7 = Piece(indexes: Indexes(x: 4, y: 8), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 2, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(piece7)
            
            let piece8 = Piece(indexes: Indexes(x: 3, y: 9), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(piece8)
            
            let piece9 = Piece(indexes: Indexes(x: 4, y: 9), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 2, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(piece9)
            
            
            addBorderAroundBoardOf(.wall, exceptionIndexes: [])



        case "test9":

            print("TEST 9")

            board.heightSpaces = 12
            board.widthSpaces = 6

            board.amountOfRandomPieces = 0

            board.randomPieceColors = [UIColor.red, UIColor.red, UIColor.red]

            board.randomPieceShapes = [.doubleElbow]//, .cross, .diagElbow, .elbow]

            let entrance = Piece(indexes: Indexes(x: 2, y: 5), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "right", doesPivot: nil)
            board.pieces.append(entrance)
            
            let doubleElbow1 = Piece(indexes: Indexes(x: 3, y: 5), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 3, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(doubleElbow1)

            let doubleElbow2 = Piece(indexes: Indexes(x: 4, y: 5), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 2, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(doubleElbow2)
            
            let doubleElbow3 = Piece(indexes: Indexes(x: 3, y: 6), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(doubleElbow3)
            
            let doubleElbow4 = Piece(indexes: Indexes(x: 4, y: 6), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(doubleElbow4)
            
            
            
            
            let entrance2 = Piece(indexes: Indexes(x: 2, y: 8), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "right", doesPivot: nil)
            board.pieces.append(entrance2)
            
            let doubleElbow8 = Piece(indexes: Indexes(x: 3, y: 8), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 3, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(doubleElbow8)

            let doubleElbow5 = Piece(indexes: Indexes(x: 4, y: 8), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 2, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(doubleElbow5)
            
            let doubleElbow6 = Piece(indexes: Indexes(x: 3, y: 9), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(doubleElbow6)
            
            let doubleElbow7 = Piece(indexes: Indexes(x: 4, y: 9), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(doubleElbow7)
            
            
            
//            let stick1 = Piece(indexes: Indexes(x: 3, y: 6), shape: .stick, colors: [UIColor.red, UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
//            board.pieces.append(stick1)
//
//            let stick2 = Piece(indexes: Indexes(x: 4, y: 6), shape: .stick, colors: [UIColor.red, UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
//            board.pieces.append(stick2)

            
            
            addBorderAroundBoardOf(.wall, exceptionIndexes: [])

        case "test10":
            
            board.heightSpaces = 12
            board.widthSpaces = 6

            board.amountOfRandomPieces = 0

            board.randomPieceColors = [UIColor.red, UIColor.red, UIColor.red]
            board.holeLocations = [Indexes(x: 1, y: 1), Indexes(x: 1, y: 2)]

            board.randomPieceShapes = [.doubleElbow]//, .cross, .diagElbow, .elbow]
            
            let ent = Piece(indexes: Indexes(x: 1, y: 8), shape: .entrance, colors: [UIColor.red, UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: "right", doesPivot: true)
            board.pieces.append(ent)
        
            let piece1 = Piece(indexes: Indexes(x: 2, y: 8), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 3, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
            board.pieces.append(piece1)
        
        
            let piece2 = Piece(indexes: Indexes(x: 3, y: 8), shape: .elbow, colors: [UIColor.red, UIColor.red], version: 2, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
            board.pieces.append(piece2)
        
        
            let piece3 = Piece(indexes: Indexes(x: 3, y: 9), shape: .elbow, colors: [UIColor.red, UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
            board.pieces.append(piece3)
            
            
            let piece4 = Piece(indexes: Indexes(x: 2, y: 9), shape: .elbow, colors: [UIColor.red, UIColor.red], version: 1, currentSwitch: 2, isLocked: false, opening: nil, doesPivot: false)
            board.pieces.append(piece4)
            
            
            
            let ent2 = Piece(indexes: Indexes(x: 1, y: 3), shape: .entrance, colors: [UIColor.red, UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: "right", doesPivot: true)
            board.pieces.append(ent2)
        
            let piece5 = Piece(indexes: Indexes(x: 2, y: 3), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 3, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
            board.pieces.append(piece5)
        
        
            let piece6 = Piece(indexes: Indexes(x: 3, y: 3), shape: .elbow, colors: [UIColor.red, UIColor.red], version: 2, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
            board.pieces.append(piece6)
        
        
            let piece7 = Piece(indexes: Indexes(x: 3, y: 4), shape: .elbow, colors: [UIColor.red, UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: false)
            board.pieces.append(piece7)
            
            
            let piece8 = Piece(indexes: Indexes(x: 2, y: 4), shape: .elbow, colors: [UIColor.red, UIColor.red], version: 1, currentSwitch: 2, isLocked: false, opening: nil, doesPivot: false)
            board.pieces.append(piece8)
            
            
            
            
            
            
            
            addBorderAroundBoardOf(.wall, exceptionIndexes: [])


        case "everything":

            board.heightSpaces = 12
            board.widthSpaces = 6

            board.amountOfRandomPieces = 10

            board.randomPieceColors = [UIColor.red, UIColor.green, UIColor.blue]

            board.randomPieceShapes = [.doubleElbow, .cross, .diagElbow, .elbow, .stick, .colorChanger]

            let entrance = Piece(indexes: Indexes(x: 2, y: 5), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "right", doesPivot: nil)
            board.pieces.append(entrance)
            
            let exit = Piece(indexes: Indexes(x: 3, y: 5), shape: .exit, colors: [UIColor.red, UIColor.red], version: 3, currentSwitch: 1, isLocked: false, opening: "top", doesPivot: true)
            board.pieces.append(exit)

            
            addBorderAroundBoardOf(.pieceMaker, exceptionIndexes: [Indexes(x: 0, y: 1), Indexes(x: 0, y: 11), Indexes(x: 6, y: 1), Indexes(x: 6, y: 11)])

            setupRowOrColumnOf(.pieceMaker, rowOrColumn: "row", index: 3, exception: [4,5], pieceMakerOpening: "top")
            
            
            
        case "Around and back":
            
            board.heightSpaces = 12
            board.widthSpaces = 6

            board.amountOfRandomPieces = 0

            board.randomPieceColors = [UIColor.red, UIColor.red, UIColor.red]

            board.randomPieceShapes = [.doubleElbow]//, .cross, .diagElbow, .elbow]

            let entrance = Piece(indexes: Indexes(x: 1, y: 6), shape: .entrance, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: "right", doesPivot: nil)
            board.pieces.append(entrance)
            
            let cross1 = Piece(indexes: Indexes(x: 2, y: 6), shape: .cross, colors: [UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: nil)
            board.pieces.append(cross1)
            
            let doubleElbow1 = Piece(indexes: Indexes(x: 3, y: 5), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 3, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(doubleElbow1)

            let doubleElbow2 = Piece(indexes: Indexes(x: 4, y: 5), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 2, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(doubleElbow2)
            
            let doubleElbow3 = Piece(indexes: Indexes(x: 3, y: 7), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(doubleElbow3)
            
            let doubleElbow4 = Piece(indexes: Indexes(x: 4, y: 7), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 1, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(doubleElbow4)
            
            let doubleElbow5 = Piece(indexes: Indexes(x: 3, y: 6), shape: .doubleElbow, colors: [UIColor.red, UIColor.red], version: 2, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(doubleElbow5)
            
            let stick2 = Piece(indexes: Indexes(x: 4, y: 6), shape: .stick, colors: [UIColor.red, UIColor.red], version: 4, currentSwitch: 1, isLocked: false, opening: nil, doesPivot: true)
            board.pieces.append(stick2)
            
            
            
            
            
            
            
            
            
            
            
        default:
            break
            
        }
        
        setUpLevelDefaults()
        
        return board

    }
    
    private func setUpLevelDefaults() {

        setupRandomPieces()
        setupNextPieces()
        setupBalls()
    }
    
    
    private func setupNextPieces() {
        
        for piece in self.board.pieces {
            
            if piece.shape == .pieceMaker {
                
                let nextPiece = Piece()
                nextPiece.indexes = piece.indexes
                setPieceShape(piece: nextPiece)
                setPieceColor(piece: nextPiece)
                setPieceSwitches(piece: nextPiece)
                setPieceSides(piece: nextPiece)
                piece.nextPiece = nextPiece
            }
        }
    }
    
    private func setPieceIndex(piece: Piece) {

        let index = Indexes(x: Int(arc4random_uniform(UInt32(board.widthSpaces))), y: Int(arc4random_uniform(UInt32(board.heightSpaces))))

        // This is to make sure that the pieces dont start on another piece
        if board.pieces.contains(where: { (pieceX) -> Bool in
            pieceX.indexes == index
        }){
            setPieceIndex(piece: piece)
        } else {
            // This is to make sure that the pieces dont start on a hole
            if board.holeLocations.contains(where: { (holeIndex) -> Bool in
                holeIndex == index
            }) {
                setPieceIndex(piece: piece)
            } else {
                piece.indexes = index
            }
        }
    }
    
    private func setPieceShape(piece: Piece) {
        
        if board.randomPieceShapes != [Shape]() {
            
            let version = Int(arc4random_uniform(UInt32(4))) + 1
            piece.version = version
            piece.shape = board.randomPieceShapes[Int(arc4random_uniform(UInt32(board.randomPieceShapes.count)))]
            
        } else {
            
            let version = Int(arc4random_uniform(UInt32(4))) + 1
            piece.version = version
            let randomShapes:[Shape] = [.diagElbow]//, .elbow, .stick]// .doubleElbow, .quadBox, .diagElbow]//, "sword"]
            piece.shape = randomShapes[Int(arc4random_uniform(UInt32(randomShapes.count)))]
            
        }
    }
    
    
    private func setPieceColor(piece: Piece) {
                
        if board.randomPieceColors != [UIColor]() {
            
            let randomColor1 = board.randomPieceColors[Int(arc4random_uniform(UInt32(board.randomPieceColors.count)))]
            let randomColor2 = board.randomPieceColors[Int(arc4random_uniform(UInt32(board.randomPieceColors.count)))]
            piece.colors = [randomColor1, randomColor2]
            
        } else {
            
            let randomColors:[UIColor] = [UIColor.red]//, UIColor.blue]//, UIColor.green, UIColor.purple, UIColor.yellow, UIColor.orange]//, UIColor.white, UIColor.cyan]
            let randomColor1 = randomColors[Int(arc4random_uniform(UInt32(randomColors.count)))]
            let randomColor2 = randomColors[Int(arc4random_uniform(UInt32(randomColors.count)))]
            piece.colors = [randomColor1, randomColor2]
        }
    }
    
    private func setPieceSwitches(piece: Piece) {
        
        let pivotDecision = Int(arc4random_uniform(UInt32(2))) + 1
        
        switch pivotDecision {
        
        case 1: //Pivot allowed
        
            switch piece.shape {
            
            case .elbow:
                
                piece.switches = 2
                piece.currentSwitch = Int(arc4random_uniform(UInt32(2))) + 1
                
            case .diagElbow:
                
                piece.switches = 2
                piece.currentSwitch = Int(arc4random_uniform(UInt32(2))) + 1
                
            case .doubleElbow:
                
                piece.switches = 2
                piece.currentSwitch = Int(arc4random_uniform(UInt32(2))) + 1
                
            case .cross:
                
                piece.switches = 2
                piece.currentSwitch = Int(arc4random_uniform(UInt32(2))) + 1
                
            case .stick:
                
                piece.switches = 1
                piece.currentSwitch = 1
                
            case .colorChanger:
                
                piece.switches = 2
                piece.currentSwitch = Int(arc4random_uniform(UInt32(2))) + 1
                
            default:
                break
            }
            
        case 2: //Pivot not allowed
        
            switch piece.shape {
            
            case .elbow:
                
                piece.doesPivot = false
                piece.switches = 1
                piece.currentSwitch = 1
                
            case .diagElbow:
                
                piece.doesPivot = false
                piece.switches = 1
                piece.currentSwitch = 1
                
            case .doubleElbow:
                
//                piece.doesPivot = false
                piece.switches = 2
                piece.currentSwitch = Int(arc4random_uniform(UInt32(2))) + 1
                
            case .cross:
                
                piece.switches = 2
                piece.currentSwitch = Int(arc4random_uniform(UInt32(2))) + 1
                
            case .stick:
                
                piece.switches = 1
                piece.currentSwitch = 1
                
            case .colorChanger:
                
                piece.switches = 2
                piece.currentSwitch = Int(arc4random_uniform(UInt32(2))) + 1
                
            default:
                break
            }
        
        default:
            break
        }
    }
    
    private func setPieceSides(piece: Piece) {
      
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
//                    piece.side.bottom.color = piece.colors[1]
                    
                    
                } else if piece.currentSwitch == 2 {
                    
                    
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
//                    piece.side.bottom.color = piece.colors[1]
                    
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
//                    piece.side.right.color = piece.colors[1]
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
//                    piece.side.right.color = piece.colors[1]
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
//                    piece.side.top.color = piece.colors[1]
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
//                    piece.side.top.color = piece.colors[1]
                    piece.side.left.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[1]

                    
                 }
                
            case 4:
                
                
                if piece.currentSwitch == 1 {
                    
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
//                    piece.side.left.color = piece.colors[0]
                    piece.side.bottom.color = piece.colors[1]
                    
                } else if piece.currentSwitch == 2 {
                    
                    
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
//                    piece.side.left.color = piece.colors[0]
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
            
        default:
            break
        }
    }
    
    private func addBorderAroundBoardOf(_ shape: Shape, exceptionIndexes: [Indexes]) {

        let corner1 = Piece(indexes: Indexes(x: 0, y: 0), shape: .wall, colors: [UIColor.gray], version: 1, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: nil)
        let corner2 = Piece(indexes: Indexes(x: 0, y: board.heightSpaces - 1), shape: .wall, colors: [UIColor.gray], version: 1, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: nil)
        let corner3 = Piece(indexes: Indexes(x: board.widthSpaces - 1, y: board.heightSpaces - 1), shape: .wall, colors: [UIColor.gray], version: 1, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: nil)
        let corner4 = Piece(indexes: Indexes(x: board.widthSpaces - 1, y: 0), shape: .wall, colors: [UIColor.gray], version: 1, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: nil)

        board.pieces.append(contentsOf: [corner1, corner2, corner3, corner4])
        
        switch shape {
        
        case .wall:
            
            setupRowOrColumnOf(.wall, rowOrColumn: "row", index: 0, exception: [], pieceMakerOpening: nil)
            setupRowOrColumnOf(.wall, rowOrColumn: "row", index: board.heightSpaces - 1, exception: [], pieceMakerOpening: nil)
            setupRowOrColumnOf(.wall, rowOrColumn: "column", index: 0, exception: [], pieceMakerOpening: nil)
            setupRowOrColumnOf(.wall, rowOrColumn: "column", index: board.widthSpaces - 1, exception: [], pieceMakerOpening: nil)
            
        case .pieceMaker:
            
            setupRowOrColumnOf(.pieceMaker, rowOrColumn: "row", index: 0, exception: [], pieceMakerOpening: "bottom")
            setupRowOrColumnOf(.pieceMaker, rowOrColumn: "row", index: board.heightSpaces - 1, exception: [], pieceMakerOpening: "top")
            setupRowOrColumnOf(.pieceMaker, rowOrColumn: "column", index: 0, exception: [], pieceMakerOpening: "left")
            setupRowOrColumnOf(.pieceMaker, rowOrColumn: "column", index: board.widthSpaces - 1, exception: [], pieceMakerOpening: "right")
            
        default:
            break
        }
        
        for exceptionIndex in exceptionIndexes {
            board.pieces.removeAll { (piece) -> Bool in
                piece.indexes == exceptionIndex
            }
        }
    }
    
    private func setupRowOrColumnOf(_ shape: Shape, rowOrColumn: String, index: Int, exception: [Int], pieceMakerOpening: String?) {
        
        if rowOrColumn == "row" {
            
            switch shape {
            case .wall:
                
                for xIndex in 0..<board.widthSpaces {
                    
                    if !board.pieces.contains(where: { (piece) -> Bool in
                        piece.indexes == Indexes(x: xIndex, y: index)
                    }) {
                        if !exception.contains(where: { (index) -> Bool in
                            index == xIndex
                        }) {
                            let wall = Piece(indexes: Indexes(x: xIndex, y: index), shape: shape, colors: [UIColor.gray], version: 1, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: nil)
                            board.pieces.append(wall)
                        }
                    }
                }
                
            case .pieceMaker:
                
                for xIndex in 0..<board.widthSpaces {
                
                    if let pieceMakerOpening = pieceMakerOpening {
                        
                        switch pieceMakerOpening {
                        case "top":
                            if !board.pieces.contains(where: { (piece) -> Bool in
                                piece.indexes == Indexes(x: xIndex, y: index)
                            }) {
                                if !exception.contains(where: { (index) -> Bool in
                                    index == xIndex
                                }) {
                                    let pieceMaker = Piece(indexes: Indexes(x: xIndex, y: index), shape: .pieceMaker, colors: [.black], version: 3, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: nil)
                                    board.pieces.append(pieceMaker)
                                }
                            }
                        case "bottom":
                            if !board.pieces.contains(where: { (piece) -> Bool in
                                piece.indexes == Indexes(x: xIndex, y: index)
                            }) {
                                if !exception.contains(where: { (index) -> Bool in
                                    index == xIndex
                                }) {

                                    let pieceMaker = Piece(indexes: Indexes(x: xIndex, y: index), shape: .pieceMaker, colors: [.black], version: 1, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: nil)
                                    board.pieces.append(pieceMaker)
                                }
                            }
                        default:
                            print("Couldnt set row of pieceMakers 1")
                        }
                        
                    } else {
                        
                        print("Couldnt set row of pieceMakers 2")
                    }
                }
                
            default:
                print("invalid shape for row or column")
            }
            
            
        } else if rowOrColumn == "column" {
            
            switch shape {
            
            case .wall:
                
                for yIndex in 0..<board.heightSpaces {
                    
                    if !board.pieces.contains(where: { (piece) -> Bool in
                        piece.indexes == Indexes(x: index, y: yIndex)
                    }) {
                        if !exception.contains(where: { (index) -> Bool in
                            index == yIndex
                        }) {

                            let piece = Piece(indexes: Indexes(x: index, y: yIndex), shape: shape, colors: [UIColor.gray], version: 1, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: nil)
                            board.pieces.append(piece)
                        }
                    }
                }
                
            case .pieceMaker:
                
                for yIndex in 0..<board.heightSpaces {

                    if let pieceMakerOpening = pieceMakerOpening {
                        
                        switch pieceMakerOpening {
                        case "left":
                            
                            if !board.pieces.contains(where: { (piece) -> Bool in
                                piece.indexes == Indexes(x: index, y: yIndex)
                            }) {
                                if !exception.contains(where: { (index) -> Bool in
                                    index == yIndex
                                }) {

                                    let pieceMaker = Piece(indexes: Indexes(x: index, y: yIndex), shape: .pieceMaker, colors: [.black], version: 4, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: nil)
                                    board.pieces.append(pieceMaker)
                                }
                            }
                            
                        case "right":
                            
                            if !board.pieces.contains(where: { (piece) -> Bool in
                                piece.indexes == Indexes(x: index, y: yIndex)
                            }) {
                                if !exception.contains(where: { (index) -> Bool in
                                    index == yIndex
                                }) {

                                    let pieceMaker = Piece(indexes: Indexes(x: index, y: yIndex), shape: .pieceMaker, colors: [.black], version: 2, currentSwitch: 1, isLocked: true, opening: nil, doesPivot: nil)
                                    board.pieces.append(pieceMaker)
                                }
                            }
                        default:
                            print("Couldnt set row of pieceMakers 1")
                        }
                        
                    } else {
                        
                        print("Couldnt set row of pieceMakers 2")
                    }
                }
            default:
                print("invalid shape for row or column")
            }
        }
    }
    
    private func setupBalls() {
        
        for piece in board.pieces {
            
            if piece.shape == .entrance {
                
                let ball = Ball()
                ball.indexes = piece.indexes
                ball.onColor = piece.colors[0]
                board.balls.append(ball)
            }
        }
    }
    
    private func setupRandomPieces() {
        
        for _ in 0..<board.amountOfRandomPieces {
            
            let piece = Piece()
            setPieceIndex(piece: piece)
            setPieceShape(piece: piece)
            setPieceColor(piece: piece)
            setPieceSwitches(piece: piece)
            setPieceSides(piece: piece)
            board.pieces.append(piece)
            
            
        }
    }
}


