//
//  ColorTheme.swift
//  PipeLord
//
//  Created by Jeffery Widroff on 06/04/2022.
//

import Foundation
import UIKit



class ColorTheme {
    
    var gameBackground = UIColor()
    var boardBackground = UIColor()
    var pieceBackground = UIColor()
    var lockedPieceBackground = UIColor()
    var holeColor = UIColor()
    var gridLineColor = UIColor()
    var lockPieceScrewColor = UIColor()
    var buttonColors = UIColor()
    var buttonTextColor = UIColor()
    
    var gradientBackgroundColor = [UIColor]()
    
    init() {
        
        gameBackground = UIColor.lightGray
        boardBackground = UIColor.black
        pieceBackground = UIColor.clear
        lockedPieceBackground = UIColor.black
        lockPieceScrewColor = UIColor.lightGray
        holeColor = gameBackground
        gridLineColor = gameBackground
        buttonColors = UIColor.white
        buttonTextColor = UIColor.black
        gradientBackgroundColor = [UIColor.yellow, UIColor.green] // DEFAULT
        
        //cross divider color
        //Piece outline color
        //Cross switch color
    }
}






