//
//  Board.swift
//  PipeLord
//
//  Created by Jeffery Widroff on 06/04/2022.
//


import Foundation
import UIKit


class Board {
    
    var grid = [Indexes: CGPoint]()
    var view = UIView()
    var iceLocations = [Indexes]()
    var holeLocations = [Indexes]()
    var randomPieceColors = [UIColor]()
    var randomPieceShapes = [Shape]()
    var amountOfRandomPieces = Int()
    var balls = [Ball]()
    var pieces = [Piece]()
    var heightSpaces = Int()
    var widthSpaces = Int()
    var colorTheme = ColorTheme()
    var moves = Int()
    var levelBalls = Int()
}

class BoardView : UIView {
    
    var context = UIGraphicsGetCurrentContext()
    var xArray = [CGFloat]()
    var yArray = [CGFloat]()
    var iceLocations = [Indexes]()
    var holeLocations = [Indexes]()
    var colorTheme = ColorTheme()

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, xArray: [CGFloat], yArray: [CGFloat], iceLocations: [Indexes], holeLocations: [Indexes], colorTheme: ColorTheme) {
        
        super.init(frame: frame)
        self.colorTheme = colorTheme
        self.xArray = xArray.sorted(by: { (x1, x2) -> Bool in
            x1 < x2
        })
        self.yArray = yArray.sorted(by: { (y1, y2) -> Bool in
            y1 < y2
        })
        
        self.iceLocations = iceLocations
        self.holeLocations = holeLocations
        
        addBoardTiles()
        addIce(iceLocations: self.iceLocations)
    }
    
    private func addGridLines(context: CGContext) {
        
        let point1 = CGPoint(x: xArray[0], y: yArray[0])
        let point2 = CGPoint(x: xArray[1], y: yArray[1])
        let halfX = (point1.x - point2.x) / 2
        let halfY = (point1.y - point2.y) / 2
        
        context.setLineWidth(2.0)
        context.beginPath()
        context.move(to: CGPoint(x: 0, y: 0))
        context.addLine(to: CGPoint(x: 0, y: frame.maxY))
        context.strokePath()
        
        context.beginPath()
        context.move(to: CGPoint(x: frame.maxX, y: 0))
        context.addLine(to: CGPoint(x: 0, y: 0))
        context.strokePath()
        
        for x in xArray {
                        
            context.beginPath()
            context.move(to: CGPoint(x: x + halfX, y: yArray.first! + halfY))
            context.addLine(to: CGPoint(x: x + halfX, y: yArray.last! - halfY))
            context.strokePath()
        }
        
        context.beginPath()
        context.move(to: CGPoint(x: frame.width, y: 0))
        context.addLine(to: CGPoint(x: frame.width, y: frame.height))
        context.strokePath()
        
        for y in yArray {
            
            context.beginPath()
            context.move(to: CGPoint(x: xArray.first! + halfX, y: y + halfY))
            context.addLine(to: CGPoint(x: xArray.last! - halfX, y: y + halfY))
            context.strokePath()
        }
        
        context.beginPath()
        context.move(to: CGPoint(x: 0, y: frame.height))
        context.addLine(to: CGPoint(x: frame.width, y: frame.height))
        context.strokePath()

        setNeedsDisplay()
        self.context = context
    }
    
    private func addBoardTiles() {
        let widthAndHeight = (xArray[1] - xArray [0])
        for x in xArray {
            for y in yArray {
                
                if !holeLocations.contains(where: { (indexesX) -> Bool in
                    self.xArray[indexesX.x!] == x && self.yArray[indexesX.y!] == y
                }) {
                    
                    let rect = CGRect(x: x, y: y, width: widthAndHeight, height: widthAndHeight)
                    let viewX = UIView(frame: rect)
                    viewX.center = CGPoint(x: x, y: y)
                    addSubview(viewX)
                    makeSoft(view: viewX)
                }
            }
        }
    }
    
    private func makeSoft(view: UIView) {
        
        view.backgroundColor = ColorTheme.boardBackground
        let shadowRadius: CGFloat = 1
        let darkShadow = CALayer()

//        let lightShadow = CALayer()
//        lightShadow.frame = view.layer.bounds
//        lightShadow.backgroundColor = ColorTheme.boardBackground.cgColor
//        lightShadow.shadowColor = UIColor.white.cgColor
//        lightShadow.shadowOffset = CGSize(width: -shadowRadius, height: -shadowRadius)
//        lightShadow.shadowOpacity = 1
////        lightShadow.cornerRadius = 5
//        view.layer.insertSublayer(lightShadow, at: 0)

        darkShadow.frame = view.layer.bounds
        darkShadow.backgroundColor = ColorTheme.boardBackground.cgColor
        darkShadow.shadowColor = UIColor.black.cgColor
        darkShadow.shadowOffset = CGSize(width: shadowRadius, height: shadowRadius)
        darkShadow.shadowOpacity = 1
//        darkShadow.cornerRadius = 5
        view.layer.insertSublayer(darkShadow, at: 1)
    }
    
    private func addIce(iceLocations: [Indexes]) {
        
        for iceLocation in self.iceLocations {

            let point1 = CGPoint(x: self.xArray[0] / 10 * 9, y: self.yArray[0] / 10 * 9)
            let point2 = CGPoint(x: self.xArray[1] / 10 * 9, y: self.yArray[1] / 10 * 9)
            let halfX = (point1.x - point2.x) / 2
            let halfY = (point1.y - point2.y) / 2

            let rect = CGRect(x: self.xArray[iceLocation.x!] - halfX, y: self.yArray[iceLocation.y!] - halfY, width: halfX * 2, height: halfY * 2)
            
            let iceView = IceView(frame: rect, iceLocation: iceLocation)
            iceView.alpha = 0.8
            addSubview(iceView)
        }
    }
    
    private func addHoles(holeLocations: [Indexes]) {
        
        
        for holeLocation in self.holeLocations {
            
            let point1 = CGPoint(x: self.xArray[0], y: self.yArray[0])
            let point2 = CGPoint(x: self.xArray[1], y: self.yArray[1])
            let halfX = (point1.x - point2.x) / 2
            let halfY = (point1.y - point2.y) / 2

            let rect = CGRect(x: self.xArray[holeLocation.x!] - halfX, y: self.yArray[holeLocation.y!] - halfY, width: halfX * 2, height: halfY * 2)
            let holeView = HoleView(frame: rect, holeLocation: holeLocation)
            addSubview(holeView)
        }
    }
    
    
    private func addHolesX(holeLocations: [Indexes], context: CGContext) {
        
        let pathToOverlay = UIBezierPath(rect: bounds)

        for holeLocation in self.holeLocations {

            let point1 = CGPoint(x: self.xArray[0], y: self.yArray[0])
            let point2 = CGPoint(x: self.xArray[1], y: self.yArray[1])
            let halfX = (point1.x - point2.x) / 2
            let halfY = (point1.y - point2.y) / 2
            let xLoc = self.xArray[holeLocation.x!] - halfX
            let yLoc = self.yArray[holeLocation.y!] - halfY
            let rect1 = CGRect(x: xLoc, y: yLoc, width: halfX * 2, height: halfY * 2)
            pathToOverlay.append(UIBezierPath(rect: rect1))
            pathToOverlay.usesEvenOddFillRule = true
            let maskLayer = CAShapeLayer()
            maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
            maskLayer.path = pathToOverlay.cgPath
            maskLayer.shadowPath = maskLayer.path
            maskLayer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            maskLayer.shadowOpacity = 0.1
            maskLayer.shadowRadius = 2
            self.layer.insertSublayer(maskLayer, at: 0)
            layer.mask = maskLayer
        }
    }
}

class IceView: UIView {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.blue
        self.frame = frame
    }
    
    init(frame: CGRect, iceLocation: Indexes) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.frame = frame
        
        let label = UILabel(frame: bounds)
        label.backgroundColor = UIColor.cyan.withAlphaComponent(0.3)
        label.text = "🧊"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: frame.height / 10 * 9)
        label.adjustsFontSizeToFitWidth = true
        self.addSubview(label)
        
        
        
//        let gradient = CAGradientLayer()
//
//        //These angle the gradient on the X & Y axis (negative numbers can be used too)
//        gradient.startPoint = .init(x: 0.0, y: 0.0)
//        gradient.endPoint = .init(x: 0.0, y: 2.0)
//
//        //This is the location of where in the middle the colors are together. (the closer they are together, the less they mesh. If its too far, you cant even notice that its 2 colors so it'll just look like one color that the two colors make)
//        gradient.locations = [-0.1, 0.5, 1.1]
//
//        //This keeps the gradient within the bounds of the view
//        gradient.frame = bounds
//        gradient.opacity = 0.5
//        //These are the colors of the gradient(that are being passed in)
//        gradient.colors = [UIColor.cyan.cgColor, UIColor.white.cgColor, UIColor.blue.cgColor]
//
//        //This determines the layer of the view you're setting the gradient (the higher up the number is, the more outer of a layer it is - which is why "gradientColors2" wont show up if gradientColors is higher and vise versa)
//        layer.insertSublayer(gradient, at: 1)
//
//        let gradient2 = CAGradientLayer()
//
//        //These angle the gradient on the X & Y axis (negative numbers can be used too)
//        gradient2.startPoint = .init(x: 0.0, y: 0.0)
//        gradient2.endPoint = .init(x: 2.0, y: 0.0)
//
//        //This is the location of where in the middle the colors are together. (the closer they are together, the less they mesh. If its too far, you cant even notice that its 2 colors so it'll just look like one color that the two colors make)
//        gradient2.locations = [-0.1, 0.5, 1.1]
//
//        //This keeps the gradient within the bounds of the view
//        gradient2.frame = bounds
//        gradient2.opacity = 0.5
//        //These are the colors of the gradient(that are being passed in)
//        gradient2.colors = [UIColor.cyan.cgColor, UIColor.blue.cgColor, UIColor.white.cgColor]
//
//
//        //This determines the layer of the view you're setting the gradient (the higher up the number is, the more outer of a layer it is - which is why "gradientColors2" wont show up if gradientColors is higher and vise versa)
//        layer.insertSublayer(gradient2, at: 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


class HoleView: UIView {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.frame = frame
    }
    
    init(frame: CGRect, holeLocation: Indexes) {
        
        super.init(frame: frame)
        self.backgroundColor = ColorTheme().gameBackground
        self.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
