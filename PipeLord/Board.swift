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
//    var wallLocations = [Indexes]()
    var randomPieceColors = [UIColor]()
    var randomPieceShapes = [Shape]()
    var amountOfRandomPieces = Int()
    var balls = [Ball]()
    var pieces = [Piece]()
    var heightSpaces = Int()
    var widthSpaces = Int()
    var colorTheme = ColorTheme()
    var moves = Int()
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
        self.backgroundColor = UIColor.clear
        self.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, xArray: [CGFloat], yArray: [CGFloat], iceLocations: [Indexes], holeLocations: [Indexes], colorTheme: ColorTheme) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.colorTheme = colorTheme
//        self.layer.shadowPath = CGPath(rect: bounds, transform: nil)
//        self.layer.shadowColor = UIColor.darkGray.cgColor
//        self.layer.shadowOffset = CGSize(width: 6, height: 0)
//        self.layer.shadowRadius = 5
//        self.layer.shadowOpacity = 1
        
        self.xArray = xArray.sorted(by: { (x1, x2) -> Bool in
            x1 < x2
        })
        self.yArray = yArray.sorted(by: { (y1, y2) -> Bool in
            y1 < y2
        })
        
        self.iceLocations = iceLocations
        self.holeLocations = holeLocations

        addIce(iceLocations: self.iceLocations)
        
        addHoles(holeLocations: self.holeLocations)
        
    }
    
    
    override func draw(_ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        
        
        
        let point1 = CGPoint(x: xArray[0], y: yArray[0])
        let point2 = CGPoint(x: xArray[1], y: yArray[1])
        let halfX = (point1.x - point2.x) / 2
        let halfY = (point1.y - point2.y) / 2
        
        
        //THE FOLLOWING IS CODE FOR THE GREDIENT. DO NOT DELETE. USE LATER ON WHEN THIS BECOMES A VIEW ON TOP OF THE BOARDVIEW

        let colorSpace = CGColorSpaceCreateDeviceRGB()

        let startColor = colorTheme.gradientBackgroundColor[0]

        guard let startColorComponents = startColor.cgColor.components else { return }

        let endColor = colorTheme.gradientBackgroundColor[1]
        
        guard let endColorComponents = endColor.cgColor.components else { return }

        let colorComponents: [CGFloat]
            = [startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3], endColorComponents[0], endColorComponents[1], endColorComponents[2], endColorComponents[3]]

        let locations:[CGFloat] = [0.0, 1.0]

        guard let gradient = CGGradient(colorSpace: colorSpace,colorComponents: colorComponents,locations: locations,count: 2) else { return }

        let startPoint = CGPoint(x: 0, y: self.bounds.height)
        let endPoint = CGPoint(x: self.bounds.width,y: self.bounds.height)

        context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: UInt32(1)))

//        context.setStrokeColor(UIColor.black.cgColor)
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

        
        
//        addHolesX(holeLocations: self.holeLocations, context: context)

        
        
        setNeedsDisplay()
        self.context = context
        
        
        
    }
    
    
    
    private func addIce(iceLocations: [Indexes]) {
        
        for iceLocation in self.iceLocations {

            let point1 = CGPoint(x: self.xArray[0], y: self.yArray[0])
            let point2 = CGPoint(x: self.xArray[1], y: self.yArray[1])
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

//            let context = UIGraphicsGetCurrentContext() else { return }
                        
            
            let point1 = CGPoint(x: self.xArray[0], y: self.yArray[0])
            let point2 = CGPoint(x: self.xArray[1], y: self.yArray[1])
            let halfX = (point1.x - point2.x) / 2
            let halfY = (point1.y - point2.y) / 2

            let rect = CGRect(x: self.xArray[holeLocation.x!] - halfX, y: self.yArray[holeLocation.y!] - halfY, width: halfX * 2, height: halfY * 2)
            
            
            print(rect)

//            
//            let pathBigRect = UIBezierPath(rect: rect)
//            
//            let smallRect = CGRect(x: rect.width / 10, y: rect.height / 10, width: rect.width / 10 * 10, height: rect.height / 10 * 10)
//            let pathSmallRect = UIBezierPath(rect: smallRect)
//            
//            
//            pathBigRect.append(pathSmallRect)
//            
//            pathBigRect.usesEvenOddFillRule = true
//            
//            
//            let fillLayer = CAShapeLayer()
//            fillLayer.path = pathBigRect.cgPath
//            fillLayer.fillRule = CAShapeLayerFillRule.evenOdd
//            fillLayer.fillColor = UIColor.clear.cgColor
//            fillLayer.opacity = 1.0
//            self.layer.addSublayer(fillLayer)
            
//
//            fillLayer.shadowPath = fillLayer.path
//            fillLayer.shadowOpacity = 0.3
//            fillLayer.shadowColor = UIColor.black.cgColor
//            fillLayer.shadowOffset = CGSize(width: -6, height: 10)
//            fillLayer.shadowRadius = 1
            
            
            
            
            
            
            
            
            let holeView = HoleView(frame: rect, holeLocation: holeLocation)

            addSubview(holeView)

        }
        
        //The following code makes a hole however when animating over it when the piece is supposed to fall into the hole, it doesnt animate at all. Also we seem to lose all the shadows etc. Need to come back to this at a later time and figure it out
        
//        let pathToOverlay = UIBezierPath(rect: bounds)
//
//        for holeLocation in self.holeLocations {
//
//            let point1 = CGPoint(x: self.xArray[0], y: self.yArray[0])
//            let point2 = CGPoint(x: self.xArray[1], y: self.yArray[1])
//            let halfX = (point1.x - point2.x) / 2
//            let halfY = (point1.y - point2.y) / 2
//
//            let rect = CGRect(x: self.xArray[holeLocation.x!] - halfX, y: self.yArray[holeLocation.y!] - halfY, width: halfX * 2, height: halfY * 2)
//
//            let maskLayer = CAShapeLayer()
//
//            maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
//            pathToOverlay.append(UIBezierPath(rect: rect))
//            pathToOverlay.usesEvenOddFillRule = true
//            maskLayer.path = pathToOverlay.cgPath
//
//            layer.mask = maskLayer
//        }
    }
    
    
    private func addHolesX(holeLocations: [Indexes], context: CGContext) {
        
        
        //The following code makes a hole however when animating over it when the piece is supposed to fall into the hole, it doesnt animate at all. Also we seem to lose all the shadows etc. Need to come back to this at a later time and figure it out
        
        let pathToOverlay = UIBezierPath(rect: bounds)

        for holeLocation in self.holeLocations {

            let point1 = CGPoint(x: self.xArray[0], y: self.yArray[0])
            let point2 = CGPoint(x: self.xArray[1], y: self.yArray[1])
            let halfX = (point1.x - point2.x) / 2
            let halfY = (point1.y - point2.y) / 2
            let xLoc = self.xArray[holeLocation.x!] - halfX
            let yLoc = self.yArray[holeLocation.y!] - halfY
            
            
//            print(self.xArray[0])
//            print(self.yArray[0])
//            print(self.xArray[1])
//            print(self.yArray[1])
//            print(xLoc)
//            print(yLoc)
//            print()

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

        let gradient = CAGradientLayer()
        
        
        //These angle the gradient on the X & Y axis (negative numbers can be used too)
        gradient.startPoint = .init(x: 0.0, y: 0.0)
        gradient.endPoint = .init(x: 0.0, y: 2.0)
        
        //This is the location of where in the middle the colors are together. (the closer they are together, the less they mesh. If its too far, you cant even notice that its 2 colors so it'll just look like one color that the two colors make)
        gradient.locations = [-0.1, 0.5, 1.1]
        
        //This keeps the gradient within the bounds of the view
        gradient.frame = bounds
        gradient.opacity = 0.5
        //These are the colors of the gradient(that are being passed in)
        gradient.colors = [UIColor.cyan.cgColor, UIColor.white.cgColor, UIColor.blue.cgColor]
        
        //This determines the layer of the view you're setting the gradient (the higher up the number is, the more outer of a layer it is - which is why "gradientColors2" wont show up if gradientColors is higher and vise versa)
        layer.insertSublayer(gradient, at: 1)
        
        let gradient2 = CAGradientLayer()
        
        //These angle the gradient on the X & Y axis (negative numbers can be used too)
        gradient2.startPoint = .init(x: 0.0, y: 0.0)
        gradient2.endPoint = .init(x: 2.0, y: 0.0)
        
        //This is the location of where in the middle the colors are together. (the closer they are together, the less they mesh. If its too far, you cant even notice that its 2 colors so it'll just look like one color that the two colors make)
        gradient2.locations = [-0.1, 0.5, 1.1]
        
        //This keeps the gradient within the bounds of the view
        gradient2.frame = bounds
        gradient2.opacity = 0.5
        //These are the colors of the gradient(that are being passed in)
        gradient2.colors = [UIColor.cyan.cgColor, UIColor.blue.cgColor, UIColor.white.cgColor]
        

        //This determines the layer of the view you're setting the gradient (the higher up the number is, the more outer of a layer it is - which is why "gradientColors2" wont show up if gradientColors is higher and vise versa)
        layer.insertSublayer(gradient2, at: 2)
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

//        let gradient = CAGradientLayer()
//
//        //These angle the gradient on the X & Y axis (negative numbers can be used too)
//        gradient.startPoint = .init(x: 0.0, y: 0.0)
//        gradient.endPoint = .init(x: 0.0, y: 1.0)
//
//        //This is the location of where in the middle the colors are together. (the closer they are together, the less they mesh. If its too far, you cant even notice that its 2 colors so it'll just look like one color that the two colors make)
//        gradient.locations = [0.1, 0.5, 0.9]
//
//        //This keeps the gradient within the bounds of the view
//        gradient.frame = bounds
//        gradient.opacity = 1.0
//        //These are the colors of the gradient(that are being passed in)
//        gradient.colors = [ColorTheme().gameBackground.cgColor]
//
//        //This determines the layer of the view you're setting the gradient (the higher up the number is, the more outer of a layer it is - which is why "gradientColors2" wont show up if gradientColors is higher and vise versa)
//        layer.insertSublayer(gradient, at: 1)
//
//        let gradient2 = CAGradientLayer()
//
//        //These angle the gradient on the X & Y axis (negative numbers can be used too)
//        gradient2.startPoint = .init(x: 0.0, y: 0.0)
//        gradient2.endPoint = .init(x: 1.0, y: 0.0)
//
//        //This is the location of where in the middle the colors are together. (the closer they are together, the less they mesh. If its too far, you cant even notice that its 2 colors so it'll just look like one color that the two colors make)
//        gradient2.locations = [0.1, 0.5, 0.9]
//
//        //This keeps the gradient within the bounds of the view
//        gradient2.frame = bounds
//        gradient2.opacity = 1.0
//        //These are the colors of the gradient(that are being passed in)
//        gradient2.colors = [ColorTheme().gameBackground.cgColor]
//
//
//        //This determines the layer of the view you're setting the gradient (the higher up the number is, the more outer of a layer it is - which is why "gradientColors2" wont show up if gradientColors is higher and vise versa)
//        layer.insertSublayer(gradient2, at: 2)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
//        let maskLayer = CAShapeLayer()
//        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
//        maskLayer.fillColor = UIColor.black.cgColor
//
//        let pathToOverlay = UIBezierPath(rect: self.bounds)
//        pathToOverlay.append(UIBezierPath(rect: frame))
//        pathToOverlay.usesEvenOddFillRule = true
//        maskLayer.path = pathToOverlay.cgPath
//
//        layer.mask = maskLayer
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
