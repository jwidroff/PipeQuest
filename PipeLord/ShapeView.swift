//
//  ShapeView.swift
//  PipeLord
//
//  Created by Jeffery Widroff on 06/04/2022.
//


import Foundation
import UIKit

class ShapeView : UIView {
    
    var shape:Shape = .regular
    var version = Int()
    var colors = [CGColor]()
    var switches = Int()
    var currentSwitch = Int()
    var isLocked = false
    var opening = String()
    var doesPivot = true
    var nextPiece: Piece?
    
    private var colorTheme = ColorTheme()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, piece: Piece) {
        
        for color in piece.colors {
            
            self.colors.append(color.cgColor)
        }
        
        super.init(frame: frame)
        self.shape = piece.shape
        self.version = piece.version
        self.isLocked = piece.isLocked
        self.opening = piece.opening
        self.doesPivot = piece.doesPivot
        
        if let nextPieceX = piece.nextPiece {
            self.nextPiece = nextPieceX
        }
        
        self.backgroundColor = colorTheme.pieceBackground
        self.switches = piece.switches
        self.currentSwitch = piece.currentSwitch
    }
    
    func setLock(context: CGContext) {
        
        let w = frame.width / 10 * 9
        let h = frame.height / 10 * 9
        let x = (frame.width - w) / 2
        let y = (frame.height - h) / 2
        let rect1 = CGRect(x: x, y: y, width: w, height: h)
        setShadow(context: context)
        context.setFillColor(colorTheme.lockedPieceBackground.cgColor)
        context.addRects([rect1])
        context.fill(rect1)
        
//        let distanceFromSides = frame.width / 10
//        let screwWidthAndHeight = frame.width / 10
//        let color = colorTheme.lockPieceScrewColor.cgColor
//
//        let topLeftCorner = CGPoint(x: distanceFromSides, y: distanceFromSides)
//        let topLeftRect = CGRect(x: topLeftCorner.x, y: topLeftCorner.y, width: screwWidthAndHeight, height: screwWidthAndHeight)
//        context.addRect(topLeftRect)
//        context.setFillColor(color)
//        context.fill(topLeftRect)
//
//        let topRightCorner = CGPoint(x: frame.width - distanceFromSides - screwWidthAndHeight, y: distanceFromSides)
//        let topRightRect = CGRect(x: topRightCorner.x, y: topRightCorner.y, width: screwWidthAndHeight, height: screwWidthAndHeight)
//        context.addRect(topRightRect)
//        context.setFillColor(color)
//        context.fill(topRightRect)
//
//        let bottomLeftCorner = CGPoint(x: distanceFromSides, y: frame.height - distanceFromSides - screwWidthAndHeight)
//        let bottomLeftRect = CGRect(x: bottomLeftCorner.x, y: bottomLeftCorner.y, width: screwWidthAndHeight, height: screwWidthAndHeight)
//        context.addRect(bottomLeftRect)
//        context.setFillColor(color)
//        context.fill(bottomLeftRect)
//
//        let bottomRightCorner = CGPoint(x: frame.width - distanceFromSides - screwWidthAndHeight, y: frame.height - distanceFromSides - screwWidthAndHeight)
//        let bottomRightRect = CGRect(x: bottomRightCorner.x, y: bottomRightCorner.y, width: screwWidthAndHeight, height: screwWidthAndHeight)
//        context.addRect(bottomRightRect)
//        context.setFillColor(color)
//        context.fill(bottomRightRect)
        
        context.restoreGState()

    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        guard let context2 = UIGraphicsGetCurrentContext() else {return}
        
        
//        let shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
//
//        context.saveGState()
//
//        context.setShadow(offset: CGSize(width: 6, height: 0), blur: 3.0, color: shadowColor.cgColor)
//        context.setFillColor(UIColor.black.cgColor)
//
//        context.fill(frame)
//
//        context.restoreGState()
        
        
//        context2.saveGState()
//
//        context2.setShadow(offset: CGSize(width: 0, height: 6), blur: 3.0, color: shadowColor.cgColor)
//        context2.setFillColor(UIColor.black.cgColor)
//
//        context2.fill(frame)
        
        
        let path = UIBezierPath()
        let path2 = UIBezierPath()
        let center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        let topCenterPoint = CGPoint(x: frame.width / 2, y: 0)
        let bottomCenterPoint = CGPoint(x: frame.width / 2, y: frame.height)
        let leftCenterPoint = CGPoint(x: 0, y: frame.height / 2)
        let rightCenterPoint = CGPoint(x: frame.width, y: frame.height / 2)
        let centerPoint = CGPoint(x: frame.width / 2, y: frame.height / 2)
        
        context.beginPath()
        context.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
        context.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        context.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        context.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        context.closePath()
        context.strokePath()
        
        context.setLineWidth(frame.height / 4)
        
        if isLocked == true {

            setLock(context: context)
        }
        
        switch shape {
        
        case .stick: //MARK: STICK VIEW
            
            switch version {
            
            case 1, 3:
                
                drawPath(path: path, context: context, pivotPoint: leftCenterPoint, center: centerPoint, endPoint: rightCenterPoint, color: colors[0])
                
            case 2, 4:
                
                drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: centerPoint, endPoint: bottomCenterPoint, color: colors[0])
                
            default:
                break
            }
            
        case .elbow: //MARK: ELBOW VIEW
            
            context.setFillColor(colors[0])
            
            switch version {
            
            case 1:
                
                //TOP PIVOT
                
                if currentSwitch == 1 {
                    
                    // TOP PIVOT TO LEFT SIDE
                    drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: center, endPoint: leftCenterPoint, color: colors[0])
                    
                } else if currentSwitch == 2 {
                    
                    // TOP PIVOT TO RIGHT SIDE
                    drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: center, endPoint: rightCenterPoint, color: colors[0])
                }
                
                if isLocked == false && doesPivot == true {
                    
                    addPivotRect(context: context, side: "top", color: colors[0])
                }
                
            case 2:
                
                //Left Pivot
 
                if currentSwitch == 1 {
                    
                    //LEFT PIVOT TO BOTTOM
                    drawPath(path: path, context: context, pivotPoint: leftCenterPoint, center: center, endPoint: bottomCenterPoint, color: colors[0])
                    
                } else if currentSwitch == 2 {
                    
                    //LEFT PIVOT TO TOP
                    drawPath(path: path, context: context, pivotPoint: leftCenterPoint, center: center, endPoint: topCenterPoint, color: colors[0])
                    
                }
                
                if isLocked == false && doesPivot == true {
                    
                    addPivotRect(context: context, side: "left", color: colors[0])
                }
                
            case 3:
                
                //Bottom pivot

                if currentSwitch == 1 {
                    
                    //BOTTOM PIVOT TO RIGHT
                    drawPath(path: path, context: context, pivotPoint: bottomCenterPoint, center: center, endPoint: rightCenterPoint, color: colors[0])
                    
                } else if currentSwitch == 2  {
                    
                    //BOTTOM PIVOT TO LEFT
                    drawPath(path: path, context: context, pivotPoint: bottomCenterPoint, center: center, endPoint: leftCenterPoint, color: colors[0])
                }
                
                if isLocked == false && doesPivot == true {
                    
                    addPivotRect(context: context, side: "bottom", color: colors[0])
                }
               
            case 4:

                //Right Pivot

                if currentSwitch == 1 {
                    
                    //RIGHT PIVOT TO TOP
                    drawPath(path: path, context: context, pivotPoint: rightCenterPoint, center: center, endPoint: topCenterPoint, color: colors[0])
                    
                } else if currentSwitch == 2  {
                    
                    //RIGHT PIVOT TO BOTTOM
                    drawPath(path: path, context: context, pivotPoint: rightCenterPoint, center: center, endPoint: bottomCenterPoint, color: colors[0])
                    
                }
                
                if isLocked == false && doesPivot == true {
                    
                    addPivotRect(context: context, side: "right", color: colors[0])
                }
                
            default:
                break
            }
            
        case .doubleElbow: //MARK: DOUBLEELBOW VIEW
            
            switch version {
            
            case 1:
                
                if currentSwitch == 1 {
                    
                    //TOP PIVOT TO RIGHT SIDE
                    
                    context2.setFillColor(colors[1])
                    
                    drawPath(path: path2, context: context2, pivotPoint: topCenterPoint, center: center, endPoint: rightCenterPoint, color: colors[1])
                    
                    if isLocked == false && doesPivot == true {
                        
                        addPivotRect(context: context2, side: "top", color: colors[1])
                    }
                    
                    //TOP PIVOT TO LEFT SIDE
                    
                    context.setFillColor(colors[0])
                    
                    drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: center, endPoint: leftCenterPoint, color: colors[0])
                    
                    if isLocked == false && doesPivot == true {
                        
                        addPivotRect(context: context, side: "top", color: colors[0])
                    }
                    
                } else if currentSwitch == 2 {
                    
                    //TOP PIVOT TO LEFT SIDE
                    
                    context.setFillColor(colors[0])
                    
                    drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: center, endPoint: leftCenterPoint, color: colors[0])
                    
                    if isLocked == false && doesPivot == true {
                        
                        addPivotRect(context: context, side: "top", color: colors[0])
                    }
                    
                    //TOP PIVOT TO RIGHT SIDE
                    
                    context2.setFillColor(colors[1])
                    
                    drawPath(path: path2, context: context2, pivotPoint: topCenterPoint, center: center, endPoint: rightCenterPoint, color: colors[1])
                    
                    if isLocked == false && doesPivot == true {
                        
                        addPivotRect(context: context2, side: "top", color: colors[1])
                    }
                }
                
            case 2:
                
                if currentSwitch == 1 {
                    
                    //LEFT PIVOT TO TOP SIDE
                    
                    context2.setFillColor(colors[1])
                    
                    drawPath(path: path2, context: context2, pivotPoint: leftCenterPoint, center: center, endPoint: topCenterPoint, color: colors[1])
                    
                    if isLocked == false && doesPivot == true {
                        
                        addPivotRect(context: context2, side: "left", color: colors[1])
                    }
                    
                    //LEFT PIVOT TO BOTTOM SIDE
                    
                    context.setFillColor(colors[0])
                    
                    drawPath(path: path, context: context, pivotPoint: leftCenterPoint, center: center, endPoint: bottomCenterPoint, color: colors[0])
                    
                    if isLocked == false && doesPivot == true {
                        
                        addPivotRect(context: context, side: "left", color: colors[0])
                    }
                    
                } else if currentSwitch == 2 {
                    
                    //LEFT PIVOT TO BOTTOM SIDE
                    
                    context.setFillColor(colors[0])
                    
                    drawPath(path: path, context: context, pivotPoint: leftCenterPoint, center: center, endPoint: bottomCenterPoint, color: colors[0])
                    
                    if isLocked == false && doesPivot == true {
                        
                        addPivotRect(context: context, side: "left", color: colors[0])
                    }
                    
                    //LEFT PIVOT TO TOP SIDE
                    
                    context2.setFillColor(colors[1])
                    
                    drawPath(path: path2, context: context2, pivotPoint: leftCenterPoint, center: center, endPoint: topCenterPoint, color: colors[1])
                    
                    if isLocked == false && doesPivot == true {
                        
                        addPivotRect(context: context2, side: "left", color: colors[1])
                    }
                }
                
            case 3:
                
                if currentSwitch == 1 {
                    
                    //BOTTOM PIVOT TO RIGHT SIDE
                    
                    context2.setFillColor(colors[1])
                    
                    drawPath(path: path2, context: context2, pivotPoint: bottomCenterPoint, center: center, endPoint: rightCenterPoint, color: colors[1])
                    
                    if isLocked == false && doesPivot == true {
                        
                        addPivotRect(context: context2, side: "bottom", color: colors[1])
                    }
                    
                    //BOTTOM PIVOT TO LEFT SIDE
                    
                    context.setFillColor(colors[0])
                    
                    drawPath(path: path, context: context, pivotPoint: bottomCenterPoint, center: center, endPoint: leftCenterPoint, color: colors[0])
                    
                    if isLocked == false && doesPivot == true {
                        
                        addPivotRect(context: context, side: "bottom", color: colors[0])
                    }
                    
                } else if currentSwitch == 2 {
                    
                    //BOTTOM PIVOT TO LEFT SIDE
                    
                    context.setFillColor(colors[0])
                    
                    drawPath(path: path, context: context, pivotPoint: bottomCenterPoint, center: center, endPoint: leftCenterPoint, color: colors[0])
                    
                    if isLocked == false && doesPivot == true {
                        
                        addPivotRect(context: context, side: "bottom", color: colors[0])
                    }
                    
                    //BOTTOM PIVOT TO RIGHT SIDE
                    
                    context2.setFillColor(colors[1])
                    
                    drawPath(path: path2, context: context2, pivotPoint: bottomCenterPoint, center: center, endPoint: rightCenterPoint, color: colors[1])
                    
                    if isLocked == false && doesPivot == true {
                        
                        addPivotRect(context: context2, side: "bottom", color: colors[1])
                    }
                }
                
            case 4:
                
                if currentSwitch == 1 {
                    
                    //RIGHT PIVOT TO BOTTOM SIDE
                    
                    context2.setFillColor(colors[1])
                    
                    drawPath(path: path2, context: context2, pivotPoint: rightCenterPoint, center: center, endPoint: bottomCenterPoint, color: colors[1])
                    
                    if isLocked == false && doesPivot == true {
                        
                        addPivotRect(context: context2, side: "right", color: colors[1])
                    }
                    
                    //RIGHT PIVOT TO TOP SIDE
                    
                    context.setFillColor(colors[0])
                    
                    drawPath(path: path, context: context, pivotPoint: rightCenterPoint, center: center, endPoint: topCenterPoint, color: colors[0])
                    
                    if isLocked == false && doesPivot == true {
                        
                        addPivotRect(context: context, side: "right", color: colors[0])
                    }
                    
                } else if currentSwitch == 2 {
                    
                    //LEFT PIVOT TO TOP SIDE
                    
                    context.setFillColor(colors[0])
                    
                    drawPath(path: path, context: context, pivotPoint: rightCenterPoint, center: center, endPoint: topCenterPoint, color: colors[0])
                    
                    if isLocked == false && doesPivot == true {
                        
                        addPivotRect(context: context, side: "right", color: colors[0])
                    }
                    
                    //RIGHT PIVOT TO BOTTOM SIDE
                    
                    context2.setFillColor(colors[1])
                    
                    drawPath(path: path2, context: context2, pivotPoint: rightCenterPoint, center: center, endPoint: bottomCenterPoint, color: colors[1])
                    
                    if isLocked == false && doesPivot == true {
                        
                        addPivotRect(context: context2, side: "right", color: colors[1])
                    }
                }
            default:
                break
            }
            
        case .diagElbow: //MARK: DIAGELBOW VIEW
            
            switch version {
            
            case 1, 3:
                
                if currentSwitch == 1 {
                    
                    //RIGHT PIVOT TO TOP SIDE
                    
                    drawPath(path: path, context: context, pivotPoint: rightCenterPoint, center: center, endPoint: topCenterPoint, color: colors[0])
                    
                    context.setFillColor(colors[0])
                    
                    if isLocked == false && doesPivot == true {
                        
                        addPivotRect(context: context, side: "right", color: colors[0])
                    }
                    
                    //LEFT PIVOT TO BOTTOM SIDE
                    
                    drawPath(path: path2, context: context2, pivotPoint: leftCenterPoint, center: center, endPoint: bottomCenterPoint, color: colors[1])
                    
                    context2.setFillColor(colors[1])
                    
                    if isLocked == false && doesPivot == true {
                        
                        addPivotRect(context: context2, side: "left", color: colors[1])
                    }
                    
                } else if currentSwitch == 2 {
                    
                    //LEFT PIVOT TO TOP SIDE
                    
                    drawPath(path: path, context: context, pivotPoint: leftCenterPoint, center: center, endPoint: topCenterPoint, color: colors[1])
                    
                    context.setFillColor(colors[1])
                    
                    if isLocked == false && doesPivot == true {
                        
                        addPivotRect(context: context, side: "left", color: colors[1])
                    }
                    
                    //RIGHT PIVOT TO BOTTOM SIDE
                    
                    drawPath(path: path2, context: context2, pivotPoint: rightCenterPoint, center: center, endPoint: bottomCenterPoint, color: colors[0])
                    
                    context2.setFillColor(colors[0])
                    
                    if isLocked == false && doesPivot == true {
                        
                        addPivotRect(context: context2, side: "right", color: colors[0])
                    }
                }
                
            case 2, 4:
                
                if currentSwitch == 1 {
                    
                    //TOP PIVOT TO LEFT SIDE
                    
                    drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: center, endPoint: leftCenterPoint, color: colors[0])
                    
                    context.setFillColor(colors[0])
                    
                    if isLocked == false && doesPivot == true {
                        
                        addPivotRect(context: context, side: "top", color: colors[0])
                    }
                    
                    //BOTTOM PIVOT TO RIGHT SIDE
                    
                    drawPath(path: path2, context: context2, pivotPoint: bottomCenterPoint, center: center, endPoint: rightCenterPoint, color: colors[1])
                    
                    context2.setFillColor(colors[1])
                    
                    if isLocked == false && doesPivot == true {
                        
                        addPivotRect(context: context2, side: "bottom", color: colors[1])
                    }
                    
                } else if currentSwitch == 2 {
                    
                    //BOTTOM PIVOT TO LEFT SIDE
                    
                    drawPath(path: path, context: context, pivotPoint: bottomCenterPoint, center: center, endPoint: leftCenterPoint, color: colors[1])
                    
                    context.setFillColor(colors[1])
                    
                    if isLocked == false && doesPivot == true {
                        
                        addPivotRect(context: context, side: "bottom", color: colors[1])
                    }
                    
                    //TOP PIVOT TO RIGHT SIDE
                    
                    drawPath(path: path2, context: context2, pivotPoint: topCenterPoint, center: center, endPoint: rightCenterPoint, color: colors[0])
                    
                    context2.setFillColor(colors[0])
                    
                    if isLocked == false && doesPivot == true {
                        
                        addPivotRect(context: context2, side: "top", color: colors[0])
                    }
                }
                
            default:
                break
            }
            
        case .cross: //MARK: CROSS VIEW
            
            switch currentSwitch {
            
            case 1:
                
                drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: centerPoint, endPoint: bottomCenterPoint, color: colors[0])
                
                drawPath(path: path2, context: context2, pivotPoint: leftCenterPoint, center: centerPoint, endPoint: rightCenterPoint, color: colors[1])
                
            case 2:
                
                drawPath(path: path2, context: context2, pivotPoint: leftCenterPoint, center: centerPoint, endPoint: rightCenterPoint, color: colors[1])
                
                drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: centerPoint, endPoint: bottomCenterPoint, color: colors[0])
                
            default:
                break
            }
            
        case .pieceMaker: //MARK: PIECEMAKER VIEW
            
            let w = frame.width / 10 * 6
            let h = frame.height / 10 * 6
            let x = (frame.width - w) / 2
            let y = x
            
            let rect1 = CGRect(x: x, y: y, width: w, height: h)
            context.setFillColor(UIColor.lightGray.cgColor)
            context.addRects([rect1])
            context.fill(rect1)
            
            switch version {
            case 1:
                
                //Spits a new piece out of the bottom
                let point1 = CGPoint(x: x, y: h + y)
                let point2 = CGPoint(x: 0, y: frame.height)
                let point3 = CGPoint(x: frame.width, y: frame.height)
                let point4 = CGPoint(x: frame.width - (x), y: h + y)
                context.beginPath()
                context.move(to: point1)
                context.addLine(to: point2)
                context.addLine(to: point3)
                context.addLine(to: point4)
                context.closePath()
                context.fillPath()
                
            case 2:
                
                //Spits a new piece out of the left
                let point1 = CGPoint(x: frame.width - (x + w), y: y)
                let point2 = CGPoint(x: 0, y: 0)
                let point3 = CGPoint(x: 0, y: frame.height)
                let point4 = CGPoint(x: frame.width - (x + w), y: frame.height - ((y)))
                context.beginPath()
                context.move(to: point1)
                context.addLine(to: point2)
                context.addLine(to: point3)
                context.addLine(to: point4)
                context.closePath()
                context.fillPath()
                
            case 3:
                
                //Spits a new piece out of the top
                let point1 = CGPoint(x: x, y: frame.height - (h + y))
                let point2 = CGPoint(x: 0, y: 0)
                let point3 = CGPoint(x: frame.width, y: 0)
                let point4 = CGPoint(x: frame.width - (x), y: frame.height - (h + y))
                context.beginPath()
                context.move(to: point1)
                context.addLine(to: point2)
                context.addLine(to: point3)
                context.addLine(to: point4)
                context.closePath()
                context.fillPath()
                
            case 4:
                
                //Spits a new piece out of the right
                let point1 = CGPoint(x: x + w, y: y)
                let point2 = CGPoint(x: frame.width, y: 0)
                let point3 = CGPoint(x: frame.width, y: frame.height)
                let point4 = CGPoint(x: x + w, y: frame.width - (y))
                context.beginPath()
                context.move(to: point1)
                context.addLine(to: point2)
                context.addLine(to: point3)
                context.addLine(to: point4)
                context.closePath()
                context.fillPath()
                
            default:
                break
            }
            
            //Show Next Piece
            let w2 = frame.width / 10 * 5
            let h2 = frame.height / 10 * 5
            let x2 = (frame.width - w2) / 2
            let y2 = x2
            let frameX = CGRect(x: x2, y: y2, width: w2, height: h2)
            let nextPieceView = ShapeView(frame: frameX, piece: nextPiece!)
            addSubview(nextPieceView)
            
        case .colorChanger: //MARK: COLORCHANGER VIEW
                        
            
            let eclipseHeight1 = frame.height / 1.75
            let eclipseWidth1 = frame.width / 1.75
            let rectX = CGRect(x: (frame.width / 2) - (eclipseWidth1 / 2), y: (frame.height / 2) - (eclipseHeight1 / 2), width: eclipseWidth1, height: eclipseHeight1)
            context.addEllipse(in: rectX)
            context.setFillColor(UIColor.black.cgColor)
            context.fillEllipse(in: rectX)
            
            
            switch version {
            
            case 1, 3:
                
                //Horizontal Line
                
                if currentSwitch == 1 {
                
                    let path3 = UIBezierPath()
                    let pivotPoint = CGPoint(x: bounds.midX, y: bounds.midY)
                    let center = CGPoint(x: bounds.midX, y: bounds.midY)
                    let endpoint3 = CGPoint(x: bounds.minX, y: bounds.midY)
                    
                    drawPath(path: path3, context: context, pivotPoint: pivotPoint, center: center, endPoint: endpoint3, color: colors[0])
                    
                    let path4 = UIBezierPath()
                    let endpoint4 = CGPoint(x: bounds.maxX, y: bounds.midY)
                    
                    drawPath(path: path4, context: context, pivotPoint: pivotPoint, center: center, endPoint: endpoint4, color: colors[1])

//                    let bottomLeft = CGPoint(x: (self.frame.width / 8), y: self.frame.height / 4 * 3)
//                    let bottomCenter = CGPoint(x: (self.frame.width / 4 * 2), y: self.frame.height / 4 * 3)
//                    let bottomRight = CGPoint(x: (self.frame.width - (self.frame.width / 8)), y: self.frame.height / 4 * 3)
//
//                    let topLeft = CGPoint(x: (self.frame.width / 8), y: self.frame.height / 4)
//                    let topCenter = CGPoint(x: (self.frame.width / 4 * 2), y: self.frame.height / 4)
//                    let topRight = CGPoint(x: (self.frame.width - (self.frame.width / 8)), y: self.frame.height / 4)
//
//                    setShadow(context: context)
//
//                    //left cresant
//                    let path = UIBezierPath()
//                    path.move(to: topCenter)
//                    path.addCurve(to: bottomCenter, controlPoint1: topLeft, controlPoint2: bottomLeft)
//                    context.setFillColor(colors[0])
//                    context.addPath(path.cgPath)
//                    context.closePath()
//                    context.fillPath()
//
//                    //right cresant
//                    let path2 = UIBezierPath()
//                    path2.move(to: topCenter)
//                    path2.addCurve(to: bottomCenter, controlPoint1: topRight, controlPoint2: bottomRight)
//                    context.setFillColor(colors[1])
//                    context.addPath(path2.cgPath)
//                    context.closePath()
//                    context.fillPath()
//
//                    context.restoreGState()
//
//                    overlapPath(path: path4, context: context, pivotPoint: pivotPoint, center: center, endPoint: endpoint4, color: colors[1])
                    
                } else if currentSwitch == 2 {
                    
                    let path3 = UIBezierPath()
                    let pivotPoint = CGPoint(x: bounds.midX, y: bounds.midY)
                    let center = CGPoint(x: bounds.midX, y: bounds.midY)
                    let endpoint3 = CGPoint(x: bounds.minX, y: bounds.midY)
                    
                    drawPath(path: path3, context: context, pivotPoint: pivotPoint, center: center, endPoint: endpoint3, color: colors[1])
                    
                    let path4 = UIBezierPath()
                    let endpoint4 = CGPoint(x: bounds.maxX, y: bounds.midY)
                    
                    drawPath(path: path4, context: context, pivotPoint: pivotPoint, center: center, endPoint: endpoint4, color: colors[0])
                    
//                    let bottomLeft = CGPoint(x: (self.frame.width / 8), y: self.frame.height / 4 * 3)
//                    let bottomCenter = CGPoint(x: (self.frame.width / 4 * 2), y: self.frame.height / 4 * 3)
//                    let bottomRight = CGPoint(x: (self.frame.width - (self.frame.width / 8)), y: self.frame.height / 4 * 3)
//
//                    let topLeft = CGPoint(x: (self.frame.width / 8), y: self.frame.height / 4)
//                    let topCenter = CGPoint(x: (self.frame.width / 4 * 2), y: self.frame.height / 4)
//                    let topRight = CGPoint(x: (self.frame.width - (self.frame.width / 8)), y: self.frame.height / 4)
//
//                    setShadow(context: context)
//
//
//                    let path = UIBezierPath()
//                    path.move(to: topCenter)
//                    path.addCurve(to: bottomCenter, controlPoint1: topLeft, controlPoint2: bottomLeft)
//                    context.setFillColor(colors[1])
//                    context.addPath(path.cgPath)
//                    context.closePath()
//                    context.fillPath()
//
//                    let path2 = UIBezierPath()
//                    path2.move(to: topCenter)
//                    path2.addCurve(to: bottomCenter, controlPoint1: topRight, controlPoint2: bottomRight)
//                    context.setFillColor(colors[0])
//                    context.addPath(path2.cgPath)
//                    context.closePath()
//                    context.fillPath()
//
//                    context.restoreGState()
//
//                    overlapPath(path: path4, context: context, pivotPoint: pivotPoint, center: center, endPoint: endpoint4, color: colors[0])
                }
                
            case 2, 4:
                
                //Vertical Line
                
                if currentSwitch == 1 {
                    
                    let path3 = UIBezierPath()
                    let pivotPoint = CGPoint(x: bounds.midX, y: bounds.midY)
                    let center = CGPoint(x: bounds.midX, y: bounds.midY)
                    let endpoint3 = CGPoint(x: bounds.midX, y: bounds.minY)
                    
                    drawPath(path: path3, context: context, pivotPoint: pivotPoint, center: center, endPoint: endpoint3, color: colors[0])
                    
                    let path4 = UIBezierPath()
                    let endpoint4 = CGPoint(x: bounds.midX, y: bounds.maxY)
                    
                    drawPath(path: path4, context: context, pivotPoint: pivotPoint, center: center, endPoint: endpoint4, color: colors[1])
                    
//                    let leftTop = CGPoint(x: self.frame.width / 4, y: self.frame.height / 8)
//                    let leftCenter = CGPoint(x: self.frame.width / 4, y: self.frame.height / 4 * 2)
//                    let leftBottom = CGPoint(x: self.frame.width / 4, y: self.frame.height - (self.frame.height / 8))
//
//                    let rightTop = CGPoint(x: self.frame.width / 4 * 3, y: self.frame.height / 8)
//                    let rightCenter = CGPoint(x: self.frame.width / 4 * 3, y: self.frame.height / 4 * 2)
//                    let rightBottom = CGPoint(x: self.frame.width / 4 * 3, y: self.frame.height - (self.frame.height / 8))
//
//                    setShadow(context: context)
//
//
//                    let path = UIBezierPath()
//                    path.move(to: leftCenter)
//                    path.addCurve(to: rightCenter, controlPoint1: leftTop, controlPoint2: rightTop)
//                    context.setFillColor(colors[0])
//                    context.addPath(path.cgPath)
//                    context.closePath()
//                    context.fillPath()
//
//                    let path2 = UIBezierPath()
//                    path2.move(to: leftCenter)
//                    path2.addCurve(to: rightCenter, controlPoint1: leftBottom, controlPoint2: rightBottom)
//                    context.setFillColor(colors[1])
//                    context.addPath(path2.cgPath)
//                    context.closePath()
//                    context.fillPath()
//
//                    context.restoreGState()
//
//                    overlapPath(path: path4, context: context, pivotPoint: pivotPoint, center: center, endPoint: endpoint4, color: colors[1])
                    
                } else if  currentSwitch == 2 {
                    
                    let path3 = UIBezierPath()
                    let pivotPoint = CGPoint(x: bounds.midX, y: bounds.midY)
                    let center = CGPoint(x: bounds.midX, y: bounds.midY)
                    let endpoint3 = CGPoint(x: bounds.midX, y: bounds.minY)
                    
                    drawPath(path: path3, context: context, pivotPoint: pivotPoint, center: center, endPoint: endpoint3, color: colors[1])
                    
                    let path4 = UIBezierPath()
                    let endpoint4 = CGPoint(x: bounds.midX, y: bounds.maxY)
                    
                    drawPath(path: path4, context: context, pivotPoint: pivotPoint, center: center, endPoint: endpoint4, color: colors[0])

//                    let leftTop = CGPoint(x: self.frame.width / 4, y: self.frame.height / 8)
//                    let leftCenter = CGPoint(x: self.frame.width / 4, y: self.frame.height / 4 * 2)
//                    let leftBottom = CGPoint(x: self.frame.width / 4, y: self.frame.height - (self.frame.height / 8))
//
//                    let rightTop = CGPoint(x: self.frame.width / 4 * 3, y: self.frame.height / 8)
//                    let rightCenter = CGPoint(x: self.frame.width / 4 * 3, y: self.frame.height / 4 * 2)
//                    let rightBottom = CGPoint(x: self.frame.width / 4 * 3, y: self.frame.height - (self.frame.height / 8))
//
//                    setShadow(context: context)
//
//
//                    let path = UIBezierPath()
//                    path.move(to: leftCenter)
//                    path.addCurve(to: rightCenter, controlPoint1: leftTop, controlPoint2: rightTop)
//                    context.setFillColor(colors[1])
//                    context.addPath(path.cgPath)
//                    context.closePath()
//                    context.fillPath()
//
//                    let path2 = UIBezierPath()
//                    path2.move(to: leftCenter)
//                    path2.addCurve(to: rightCenter, controlPoint1: leftBottom, controlPoint2: rightBottom)
//                    context.setFillColor(colors[0])
//                    context.addPath(path2.cgPath)
//                    context.closePath()
//                    context.fillPath()
//
//
//                    context.restoreGState()
//
//
//                    overlapPath(path: path4, context: context, pivotPoint: pivotPoint, center: center, endPoint: endpoint4, color: colors[0])
                    
                }
            default:
                break
            }
            
        case .entrance, .exit: //MARK: ENT & EXIT VIEW
            
            switch opening {
            
            case "top":
                
                let center = CGPoint(x: bounds.midX, y: bounds.midY)
                let endPoint = CGPoint(x: bounds.midX, y: bounds.minY)
                
                drawPath(path: path, context: context, pivotPoint: center, center: center, endPoint: endPoint, color: colors[0])
                
                setShadow(context: context)
                
                
                let eclipseHeight1 = frame.height / 1.75
                let eclipseWidth1 = frame.width / 1.75
                let rect2 = CGRect(x: (frame.width / 2) - (eclipseWidth1 / 2), y: (frame.height / 2) - (eclipseHeight1 / 2), width: eclipseWidth1, height: eclipseHeight1)
                context.setFillColor(UIColor.black.cgColor)
                context.addEllipse(in: rect2)
                context.fillEllipse(in: rect2)
                
                let eclipseHeight2 = frame.height / 2
                let eclipseWidth2 = frame.width / 2
                let rect3 = CGRect(x: (frame.width / 2) - (eclipseWidth2 / 2), y: (frame.height / 2) - (eclipseHeight2 / 2), width: eclipseWidth2, height: eclipseHeight2)
                context.setFillColor(colors[0])
                context.addEllipse(in: rect3)
                context.fillEllipse(in: rect3)
                
                context.restoreGState()
                
                overlapPath(path: path, context: context, pivotPoint: center, center: center, endPoint: endPoint, color: colors[0])
                
            case "bottom":
                
                let center = CGPoint(x: bounds.midX, y: bounds.midY)
                let endPoint = CGPoint(x: bounds.midX, y: bounds.maxY)
                
                drawPath(path: path, context: context, pivotPoint: center, center: center, endPoint: endPoint, color: colors[0])
                
                setShadow(context: context)
                
                let eclipseHeight1 = frame.height / 1.75
                let eclipseWidth1 = frame.width / 1.75
                let rect2 = CGRect(x: (frame.width / 2) - (eclipseWidth1 / 2), y: (frame.height / 2) - (eclipseHeight1 / 2), width: eclipseWidth1, height: eclipseHeight1)
                context.setFillColor(UIColor.black.cgColor)
                context.addEllipse(in: rect2)
                context.fillEllipse(in: rect2)

                let eclipseHeight2 = frame.height / 2
                let eclipseWidth2 = frame.width / 2
                let rect3 = CGRect(x: (frame.width / 2) - (eclipseWidth2 / 2), y: (frame.height / 2) - (eclipseHeight2 / 2), width: eclipseWidth2, height: eclipseHeight2)
                context.setFillColor(colors[0])
                context.addEllipse(in: rect3)
                context.fillEllipse(in: rect3)
                
                context.restoreGState()
                
                overlapPath(path: path, context: context, pivotPoint: center, center: center, endPoint: endPoint, color: colors[0])
                
            case "left":
                
                let center = CGPoint(x: bounds.midX, y: bounds.midY)
                let endPoint = CGPoint(x: bounds.minX, y: bounds.midY)
                
                drawPath(path: path, context: context, pivotPoint: center, center: center, endPoint: endPoint, color: colors[0])
                
                setShadow(context: context)
                
                let eclipseHeight1 = frame.height / 1.75
                let eclipseWidth1 = frame.width / 1.75
                let rect2 = CGRect(x: (frame.width / 2) - (eclipseWidth1 / 2), y: (frame.height / 2) - (eclipseHeight1 / 2), width: eclipseWidth1, height: eclipseHeight1)
                context.setFillColor(UIColor.black.cgColor)
                context.addEllipse(in: rect2)
                context.fillEllipse(in: rect2)

                let eclipseHeight2 = frame.height / 2
                let eclipseWidth2 = frame.width / 2
                let rect3 = CGRect(x: (frame.width / 2) - (eclipseWidth2 / 2), y: (frame.height / 2) - (eclipseHeight2 / 2), width: eclipseWidth2, height: eclipseHeight2)
                context.setFillColor(colors[0])
                context.addEllipse(in: rect3)
                context.fillEllipse(in: rect3)
                
                context.restoreGState()
                
                overlapPath(path: path, context: context, pivotPoint: center, center: center, endPoint: endPoint, color: colors[0])
                
            case "right":
                
                let center = CGPoint(x: bounds.midX, y: bounds.midY)
                let endPoint = CGPoint(x: bounds.maxX, y: bounds.midY)
                
                drawPath(path: path, context: context, pivotPoint: center, center: center, endPoint: endPoint, color: colors[0])
                
                setShadow(context: context)
                
                let eclipseHeight1 = frame.height / 1.75
                let eclipseWidth1 = frame.width / 1.75
                let rect2 = CGRect(x: (frame.width / 2) - (eclipseWidth1 / 2), y: (frame.height / 2) - (eclipseHeight1 / 2), width: eclipseWidth1, height: eclipseHeight1)
                context.setFillColor(UIColor.black.cgColor)
                context.addEllipse(in: rect2)
                context.fillEllipse(in: rect2)

                let eclipseHeight2 = frame.height / 2
                let eclipseWidth2 = frame.width / 2
                let rect3 = CGRect(x: (frame.width / 2) - (eclipseWidth2 / 2), y: (frame.height / 2) - (eclipseHeight2 / 2), width: eclipseWidth2, height: eclipseHeight2)
                context.setFillColor(colors[0])
                context.addEllipse(in: rect3)
                context.fillEllipse(in: rect3)
                
                context.restoreGState()
                
                overlapPath(path: path, context: context, pivotPoint: center, center: center, endPoint: endPoint, color: colors[0])
                
            default:
                
                break
            }
            
        case .wall: //MARK: WALL VIEW
            
            let eclipseHeight2 = frame.height / 2
            let eclipseWidth2 = frame.width / 2
            let rect3 = CGRect(x: (frame.width / 2) - (eclipseWidth2 / 2), y: (frame.height / 2) - (eclipseHeight2 / 2), width: eclipseWidth2, height: eclipseHeight2)
            context.setFillColor(UIColor.darkGray.cgColor)
            context.addEllipse(in: rect3)
            context.fillEllipse(in: rect3)
            
            
            
            print()
            
        case .ball: //MARK: BALL VIEW
            
            let eclipseHeight1 = frame.height / 4
            let eclipseWidth1 = frame.width / 4
            let rect1 = CGRect(x: (frame.width / 2) - (eclipseWidth1 / 2), y: (frame.height / 2) - (eclipseHeight1 / 2), width: eclipseWidth1, height: eclipseHeight1)
            context.addEllipse(in: rect1)
            context.setFillColor(UIColor.black.cgColor)
            context.fillEllipse(in: rect1)
            
            guard let context2 = UIGraphicsGetCurrentContext() else { return }
            let eclipseHeight2 = frame.height / 5
            let eclipseWidth2 = frame.width / 5
            let rect2 = CGRect(x: (frame.width / 2) - (eclipseWidth2 / 2), y: (frame.height / 2) - (eclipseHeight2 / 2), width: eclipseWidth2, height: eclipseHeight2)
            context2.addEllipse(in: rect2)
            context2.setFillColor(UIColor.black.cgColor)
            context2.fillEllipse(in: rect2)
            
        case .regular:
            
            print("SOMETHING WENT WRONG HERE")
            
            let w = frame.width / 10 * 9
            let h = frame.height / 10 * 9
            let x = (frame.width - w) / 2
            let y = (frame.height - h) / 2
            let rect1 = CGRect(x: x, y: y, width: w, height: h)
            context.addRects([rect1])
            context.fill(rect1)
        }
        
//        context.restoreGState()
    }
    
    func addPivotRect(context: CGContext, side: String, color: CGColor) {
        
        switch side {
        
        case "top":
            
            let width = bounds.width / 2
            let x = (bounds.midX - (width / 2))
            let pivotRect2 = CGRect(x: x, y: bounds.minY, width: width, height: bounds.height / 10)
            let rect2 = CGRect(x: pivotRect2.minX - pivotRect2.width * 0.1 , y: 0, width: pivotRect2.width + (pivotRect2.width * 0.2), height: pivotRect2.height + (pivotRect2.height * 0.2))
            context.addRects([rect2])
            context.setFillColor(colorTheme.boardBackground.cgColor)
            context.fill(rect2)
            context.setFillColor(color)
            context.addRects([pivotRect2])
            context.fill(pivotRect2)
            
        case "bottom":
            
            let width = bounds.width / 2
            let x = (bounds.midX - (width / 2))
            let pivotRect = CGRect(x: x, y: bounds.maxY - (bounds.height / 10), width: width, height: bounds.height / 10)
            let rect = CGRect(x: pivotRect.minX - pivotRect.width * 0.1 , y: pivotRect.minY - pivotRect.height * 0.2, width: pivotRect.width + (pivotRect.width * 0.2), height: pivotRect.height + (pivotRect.height * 0.2))
            context.addRects([rect])
            context.setFillColor(colorTheme.boardBackground.cgColor)
            context.fill(rect)
            context.setFillColor(color)
            context.addRects([pivotRect])
            context.fill(pivotRect)
            
        case "left":
            
            let height = bounds.height / 2
            let y = (bounds.midY - (height / 2))
            let pivotRect2 = CGRect(x: bounds.minX, y: y, width: bounds.width / 10, height: height)
            let rect2 = CGRect(x: 0 , y: pivotRect2.minY - pivotRect2.height * 0.1, width: pivotRect2.width + (pivotRect2.width * 0.2), height: pivotRect2.height + (pivotRect2.height * 0.2))
            context.addRects([rect2])
            context.setFillColor(colorTheme.boardBackground.cgColor)
            context.fill(rect2)
            context.setFillColor(color)
            context.addRects([pivotRect2])
            context.fill(pivotRect2)
            
        case "right":
            
            let height = bounds.height / 2
            let y = (bounds.midY - (height / 2))
            let pivotRect = CGRect(x: bounds.maxX - (bounds.height / 10), y: y, width: bounds.width / 10, height: height)
            let rect = CGRect(x: pivotRect.minX - pivotRect.width * 0.2 , y: pivotRect.minY - pivotRect.height * 0.1, width: pivotRect.width + (pivotRect.width * 0.2), height: pivotRect.height + (pivotRect.height * 0.2))
            context.addRects([rect])
            context.setFillColor(colorTheme.boardBackground.cgColor)
            context.fill(rect)
            context.setFillColor(color)
            context.addRects([pivotRect])
            context.fill(pivotRect)
            
        default:
            break
        }
    }
    
    func setShadow(context: CGContext) {
        
//        let shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)

//        let shadowColor = UIColor.black
        
        context.saveGState()

//        context.setShadow(offset: CGSize(width: 5, height: 0), blur: 2.0, color: shadowColor.cgColor)
//        context.setFillColor(UIColor.black.cgColor)
//
//        context.fill(frame)
    }
    
    
    func drawPath(path: UIBezierPath, context: CGContext, pivotPoint: CGPoint, center: CGPoint, endPoint: CGPoint, color: CGColor) {

        setShadow(context: context)
        
        path.move(to: pivotPoint)
        path.addQuadCurve(to: endPoint, controlPoint: center)

        context.addPath(path.cgPath)
//        context.setStrokeColor(colorTheme.boardBackground.cgColor)
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(frame.height / 3)
        context.strokePath()
        
        path.move(to: pivotPoint)
        path.addQuadCurve(to: endPoint, controlPoint: center)
        
        context.addPath(path.cgPath)
        
        
        
        
        
        
        context.setStrokeColor(color)
        

        
        
        
        
        context.setLineWidth(frame.height / 4)
        context.strokePath()
        
        
        context.restoreGState()
        
    }
    
    func overlapPath(path: UIBezierPath, context: CGContext, pivotPoint: CGPoint, center: CGPoint, endPoint: CGPoint, color: CGColor) {
        
//        context.restoreGState()
        
        path.move(to: pivotPoint)
        path.addQuadCurve(to: endPoint, controlPoint: center)
        
        context.addPath(path.cgPath)
        context.setStrokeColor(color)
        context.setLineWidth(frame.height / 4)
        context.strokePath()
    }
    
}


class BallView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let shadowColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)

        context.saveGState()

        context.setShadow(offset: CGSize(width: 0, height: 6), blur: 3.0, color: shadowColor.cgColor)
        context.setFillColor(UIColor.black.cgColor)

        context.fill(frame)
        
        let eclipseHeight1 = frame.height / 4
        let eclipseWidth1 = frame.width / 4
        let rect1 = CGRect(x: (frame.width / 2) - (eclipseWidth1 / 2), y: (frame.height / 2) - (eclipseHeight1 / 2), width: eclipseWidth1, height: eclipseHeight1)
        context.addEllipse(in: rect1)
        context.setFillColor(UIColor.black.cgColor)
        context.fillEllipse(in: rect1)
        
        let eclipseHeight2 = frame.height / 5
        let eclipseWidth2 = frame.width / 5
        let rect2 = CGRect(x: (frame.width / 2) - (eclipseWidth2 / 2), y: (frame.height / 2) - (eclipseHeight2 / 2), width: eclipseWidth2, height: eclipseHeight2)
        context.addEllipse(in: rect2)
        context.setFillColor(UIColor.white.cgColor)
        context.fillEllipse(in: rect2)
    }
}

enum Shape {
    
    case elbow
    case diagElbow
    case cross
    case stick
    case colorChanger
    case doubleElbow
    //    case ballStopper
    case entrance
    case exit
    case wall
    case pieceMaker
    
    case ball
    case regular
}





