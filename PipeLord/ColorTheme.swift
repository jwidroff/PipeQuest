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
        boardBackground = UIColor.clear
        pieceBackground = UIColor.clear
        lockedPieceBackground = UIColor.black
        lockPieceScrewColor = UIColor.lightGray
        holeColor = gameBackground
        gridLineColor = gameBackground
        buttonColors = UIColor.white
        buttonTextColor = UIColor.black
        gradientBackgroundColor = [UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0), UIColor.init(red: 0.9, green: 0.1, blue: 0.7, alpha: 1.0)] // DEFAULT
        
        //cross divider color
        //Piece outline color
        //Cross switch color
    }
}

struct PieceColors {
    
    static var red = UIColor.init(red: 0.8, green: 0.4, blue: 0.0, alpha: 0.8)
    
    static var blue = UIColor.init(red: 0.0, green: 0.8, blue: 0.8, alpha: 0.8)
    static var green = UIColor.init(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.8)
    
}






