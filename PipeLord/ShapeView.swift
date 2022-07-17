//
//  ShapeView.swift
//  PipeLord
//
//  Created by Jeffery Widroff on 06/04/2022.
//


import Foundation
import UIKit

class ShapeView : UIView {
    
    var shape:Shape = .blank
    var version = Int()
    var colors = [CGColor]()
    var switches = Int()
    var isLocked: Bool?
    var doesPivot: Bool?
    var nextPiece: Piece?
    var context : CGContext?
    var rotations = 0
    
    private var colorTheme = ColorTheme()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, piece: Piece) {

        super.init(frame: frame)

        if let nextPieceX = piece.nextPiece {
            self.nextPiece = nextPieceX
        }
        
        isLocked = piece.isLocked
        doesPivot = piece.doesPivot

        makeSoft()
        addTopView(piece: piece)
    }
    
    func addTopView(piece: Piece) {
        let frameX = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        let topView = ShapeViewTopView(frame: frameX, piece: piece)
        self.addSubview(topView)
    }
    
    func makeSoft() {
        self.layer.masksToBounds = false
        var cornerRadius: CGFloat = 1
        var frame = CGRect.zero
        
        if doesPivot == false {
            
            cornerRadius = 5
            frame = self.bounds
            
        } else {

            cornerRadius = self.frame.width / 2
            frame = self.layer.bounds
        }
        
        let shadowRadius: CGFloat = 1
        let darkShadow = CALayer()
        darkShadow.frame = frame
        darkShadow.backgroundColor = ColorTheme.boardBackground.cgColor
        darkShadow.shadowColor = UIColor.black.cgColor
        darkShadow.cornerRadius = cornerRadius
        darkShadow.shadowOffset = CGSize(width: shadowRadius, height: shadowRadius)
        darkShadow.shadowOpacity = 1
        darkShadow.shadowRadius = shadowRadius
        self.layer.insertSublayer(darkShadow, at: 0)

        let lightShadow = CALayer()
        lightShadow.frame = self.layer.bounds
        lightShadow.backgroundColor = ColorTheme.boardBackground.cgColor
        lightShadow.shadowColor = UIColor.white.cgColor
        lightShadow.cornerRadius = cornerRadius
        lightShadow.shadowOffset = CGSize(width: -shadowRadius, height: -shadowRadius)
        lightShadow.shadowOpacity = 1
        lightShadow.shadowRadius = shadowRadius
        self.layer.insertSublayer(lightShadow, at: 1)
    }
}

class ShapeViewTopView: UIView {
    
    var shape:Shape = .blank
    var version = Int()
    var colors = [CGColor]()
    var switches = Int()
    var isLocked = false
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
        self.doesPivot = piece.doesPivot
        
        if let nextPieceX = piece.nextPiece {
            self.nextPiece = nextPieceX
        }
        
        self.backgroundColor = .clear
        self.layer.cornerRadius = 2
        self.clipsToBounds = true
        if piece.doesPivot == true {
            
            self.layer.cornerRadius = self.frame.width / 2
            
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        guard let context2 = UIGraphicsGetCurrentContext() else {return}
        let path = UIBezierPath()
        let path2 = UIBezierPath()
        let center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        let topCenterPoint = CGPoint(x: frame.width / 2, y: 0)
        let bottomCenterPoint = CGPoint(x: frame.width / 2, y: frame.height)
        let leftCenterPoint = CGPoint(x: 0, y: frame.height / 2)
        let rightCenterPoint = CGPoint(x: frame.width, y: frame.height / 2)
        let centerPoint = CGPoint(x: frame.width / 2, y: frame.height / 2)
        context.setLineWidth(frame.height / 4)
        
        if isLocked == true {
            
            context.saveGState()
            context.setFillColor(colorTheme.lockedPieceBackground.cgColor)
            context.fill(rect)
            context.restoreGState()
        }
        
        switch shape {
            
            
        case .blank:

            print()
//            backgroundColor = PieceColors.green
            

        case .elbow: //MARK: ELBOW VIEW
            
            context.setFillColor(colors[0])
            
            switch version {
            
            case 1:
                
                
                
                drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: center, endPoint: leftCenterPoint, color: colors[0])
            case 2:
                drawPath(path: path, context: context, pivotPoint: rightCenterPoint, center: center, endPoint: topCenterPoint, color: colors[0])
            case 3:
                drawPath(path: path, context: context, pivotPoint: bottomCenterPoint, center: center, endPoint: rightCenterPoint, color: colors[0])
            case 4:
                drawPath(path: path, context: context, pivotPoint: leftCenterPoint, center: center, endPoint: bottomCenterPoint, color: colors[0])
                
            default:
                break
            }
            
        case .doubleElbow: //MARK: DOUBLEELBOW VIEW
            
            switch version {
                
            case 1:
                context2.setFillColor(colors[1])
                drawPath(path: path2, context: context2, pivotPoint: topCenterPoint, center: center, endPoint: rightCenterPoint, color: colors[1])
                
                context.setFillColor(colors[0])
                drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: center, endPoint: leftCenterPoint, color: colors[0])
            case 2:
                context.setFillColor(colors[1])
                drawPath(path: path, context: context, pivotPoint: rightCenterPoint, center: center, endPoint: bottomCenterPoint, color: colors[1])
                
                context2.setFillColor(colors[0])
                drawPath(path: path2, context: context2, pivotPoint: rightCenterPoint, center: center, endPoint: topCenterPoint, color: colors[0])
            case 3:
                context.setFillColor(colors[1])
                drawPath(path: path, context: context, pivotPoint: bottomCenterPoint, center: center, endPoint: leftCenterPoint, color: colors[1])
                
                context2.setFillColor(colors[0])
                drawPath(path: path2, context: context2, pivotPoint: bottomCenterPoint, center: center, endPoint: rightCenterPoint, color: colors[0])
            case 4:
                context2.setFillColor(colors[1])
                drawPath(path: path2, context: context2, pivotPoint: leftCenterPoint, center: center, endPoint: topCenterPoint, color: colors[1])
                
                context.setFillColor(colors[0])
                drawPath(path: path, context: context, pivotPoint: leftCenterPoint, center: center, endPoint: bottomCenterPoint, color: colors[0])
            case 5:
                context.setFillColor(colors[0])
                drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: center, endPoint: leftCenterPoint, color: colors[0])
                
                context2.setFillColor(colors[1])
                drawPath(path: path2, context: context2, pivotPoint: topCenterPoint, center: center, endPoint: rightCenterPoint, color: colors[1])
            case 6:
                context2.setFillColor(colors[0])
                drawPath(path: path2, context: context2, pivotPoint: rightCenterPoint, center: center, endPoint: topCenterPoint, color: colors[0])
                
                context.setFillColor(colors[1])
                drawPath(path: path, context: context, pivotPoint: rightCenterPoint, center: center, endPoint: bottomCenterPoint, color: colors[1])
            case 7:
                context2.setFillColor(colors[0])
                drawPath(path: path2, context: context2, pivotPoint: bottomCenterPoint, center: center, endPoint: rightCenterPoint, color: colors[0])
                
                context.setFillColor(colors[1])
                drawPath(path: path, context: context, pivotPoint: bottomCenterPoint, center: center, endPoint: leftCenterPoint, color: colors[1])
            case 8:
                context.setFillColor(colors[0])
                drawPath(path: path, context: context, pivotPoint: leftCenterPoint, center: center, endPoint: bottomCenterPoint, color: colors[0])
                
                context2.setFillColor(colors[1])
                drawPath(path: path2, context: context2, pivotPoint: leftCenterPoint, center: center, endPoint: topCenterPoint, color: colors[1])
            default:
                break
            }
            
        case .diagElbow: //MARK: DIAGELBOW VIEW
            
            switch version {
            
            case 1:
                drawPath(path: path, context: context, pivotPoint: rightCenterPoint, center: center, endPoint: topCenterPoint, color: colors[0])
                
                context.setFillColor(colors[0])
                
                drawPath(path: path2, context: context2, pivotPoint: leftCenterPoint, center: center, endPoint: bottomCenterPoint, color: colors[1])
                
                context2.setFillColor(colors[1])
                
            case 2:
                drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: center, endPoint: leftCenterPoint, color: colors[1])
                
                context.setFillColor(colors[1])
                
                drawPath(path: path2, context: context2, pivotPoint: bottomCenterPoint, center: center, endPoint: rightCenterPoint, color: colors[0])
                
                context2.setFillColor(colors[0])
                
                
            case 3:
                
                drawPath(path: path, context: context, pivotPoint: rightCenterPoint, center: center, endPoint: topCenterPoint, color: colors[1])
                
                context.setFillColor(colors[1])
                
                drawPath(path: path2, context: context2, pivotPoint: leftCenterPoint, center: center, endPoint: bottomCenterPoint, color: colors[0])
                
                context2.setFillColor(colors[0])
                
                
            case 4:
                
                drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: center, endPoint: leftCenterPoint, color: colors[0])
                
                context.setFillColor(colors[0])
                
                drawPath(path: path2, context: context2, pivotPoint: bottomCenterPoint, center: center, endPoint: rightCenterPoint, color: colors[1])
                
                context2.setFillColor(colors[1])
                
                
                
            default:
                break
            }
            
        case .cross: //MARK: CROSS VIEW
            
            switch version {
            
            case 1:
                drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: centerPoint, endPoint: bottomCenterPoint, color: colors[0])
                
                drawPath(path: path2, context: context2, pivotPoint: leftCenterPoint, center: centerPoint, endPoint: rightCenterPoint, color: colors[1])
            case 2:
                drawPath(path: path2, context: context2, pivotPoint: leftCenterPoint, center: centerPoint, endPoint: rightCenterPoint, color: colors[0])
                
                drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: centerPoint, endPoint: bottomCenterPoint, color: colors[1])
            case 3:
                drawPath(path: path2, context: context2, pivotPoint: leftCenterPoint, center: centerPoint, endPoint: rightCenterPoint, color: colors[1])
                
                drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: centerPoint, endPoint: bottomCenterPoint, color: colors[0])
            case 4:
                drawPath(path: path, context: context, pivotPoint: topCenterPoint, center: centerPoint, endPoint: bottomCenterPoint, color: colors[1])
                drawPath(path: path2, context: context2, pivotPoint: leftCenterPoint, center: centerPoint, endPoint: rightCenterPoint, color: colors[0])
            default:
                break
            }
            
        case .pieceMaker: //MARK: PIECEMAKER VIEW
            
            let w = frame.width / 2
            let h = frame.height / 2
            let x = ((frame.width / 9 * 10) - w) / 2
            let y = x
            let fillColor = UIColor(red: 0.0, green: 9.0, blue: 0.5, alpha: 0.5).cgColor
            
            context.setFillColor(fillColor)

            switch version {
            case 1:
                
                //Spits a new piece out of the bottom
                let point1 = CGPoint(x: x, y: h )
                let point2 = CGPoint(x: 0, y: frame.height)
                let point3 = CGPoint(x: frame.width , y: frame.height)
                let point4 = CGPoint(x: frame.width - (x), y: h )
                context.beginPath()
                context.move(to: point1)
                context.addLine(to: point2)
                context.addLine(to: point3)
                context.addLine(to: point4)
                context.closePath()
                context.fillPath()
                
            case 2:
                
                //Spits a new piece out of the left
                let point1 = CGPoint(x: frame.width - ( w), y: y)
                let point2 = CGPoint(x: 0, y: 0)
                let point3 = CGPoint(x: 0, y: frame.height)
                let point4 = CGPoint(x: frame.width - (w), y: frame.height - ((y)))
                context.beginPath()
                context.move(to: point1)
                context.addLine(to: point2)
                context.addLine(to: point3)
                context.addLine(to: point4)
                context.closePath()
                context.fillPath()
                
            case 3:
                
                //Spits a new piece out of the top
                let point1 = CGPoint(x: x, y: frame.height - ( y))
                let point2 = CGPoint(x: 0, y: 0)
                let point3 = CGPoint(x: frame.width, y: 0)
                let point4 = CGPoint(x: frame.width - (x), y: frame.height - ( y))
                context.beginPath()
                context.move(to: point1)
                context.addLine(to: point2)
                context.addLine(to: point3)
                context.addLine(to: point4)
                context.closePath()
                context.fillPath()
                
            case 4:
                
                //Spits a new piece out of the right
                let point1 = CGPoint(x:  w, y: y)
                let point2 = CGPoint(x: frame.width, y: 0)
                let point3 = CGPoint(x: frame.width, y: frame.height)
                let point4 = CGPoint(x: w, y: frame.width - (y))
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
            nextPieceView.layer.cornerRadius = nextPieceView.frame.width / 2
            nextPieceView.layer.shadowRadius = 0
            
        case .stick: //MARK: STICK VIEW
                        
            switch version { //MARK: Had to make changes here
            
            case 1:
                let path3 = UIBezierPath()
                let pivotPoint = CGPoint(x: bounds.midX, y: bounds.midY)
                let center = CGPoint(x: bounds.midX, y: bounds.midY)
                let endpoint3 = CGPoint(x: bounds.minX, y: bounds.midY)
                
                drawPath(path: path3, context: context, pivotPoint: pivotPoint, center: center, endPoint: endpoint3, color: colors[0])
                
                let path4 = UIBezierPath()
                let endpoint4 = CGPoint(x: bounds.maxX, y: bounds.midY)
                
                drawPath(path: path4, context: context, pivotPoint: pivotPoint, center: center, endPoint: endpoint4, color: colors[1])
                
            case 2:
                
                let path3 = UIBezierPath()
                let pivotPoint = CGPoint(x: bounds.midX, y: bounds.midY)
                let center = CGPoint(x: bounds.midX, y: bounds.midY)
                let endpoint3 = CGPoint(x: bounds.midX, y: bounds.minY)
                
                drawPath(path: path3, context: context, pivotPoint: pivotPoint, center: center, endPoint: endpoint3, color: colors[0])
                
                let path4 = UIBezierPath()
                let endpoint4 = CGPoint(x: bounds.midX, y: bounds.maxY)
                
                drawPath(path: path4, context: context, pivotPoint: pivotPoint, center: center, endPoint: endpoint4, color: colors[1])
                
            case 3:
                
                let path3 = UIBezierPath()
                let pivotPoint = CGPoint(x: bounds.midX, y: bounds.midY)
                let center = CGPoint(x: bounds.midX, y: bounds.midY)
                let endpoint3 = CGPoint(x: bounds.minX, y: bounds.midY)
                
                drawPath(path: path3, context: context, pivotPoint: pivotPoint, center: center, endPoint: endpoint3, color: colors[1])
                
                let path4 = UIBezierPath()
                let endpoint4 = CGPoint(x: bounds.maxX, y: bounds.midY)
                
                drawPath(path: path4, context: context, pivotPoint: pivotPoint, center: center, endPoint: endpoint4, color: colors[0])
                
            case 4:
                
                let path3 = UIBezierPath()
                let pivotPoint = CGPoint(x: bounds.midX, y: bounds.midY)
                let center = CGPoint(x: bounds.midX, y: bounds.midY)
                let endpoint3 = CGPoint(x: bounds.midX, y: bounds.minY)
                
                drawPath(path: path3, context: context, pivotPoint: pivotPoint, center: center, endPoint: endpoint3, color: colors[1])
                
                let path4 = UIBezierPath()
                let endpoint4 = CGPoint(x: bounds.midX, y: bounds.maxY)
                
                drawPath(path: path4, context: context, pivotPoint: pivotPoint, center: center, endPoint: endpoint4, color: colors[0])
                
            default:
                break
            }
            
        case .entrance, .exit: //MARK: ENT & EXIT VIEW
            
            switch version {
            
            case 1:
                let center = CGPoint(x: bounds.midX, y: bounds.midY)
                let endPoint = CGPoint(x: bounds.midX, y: bounds.minY)
                
                drawPath(path: path, context: context, pivotPoint: center, center: center, endPoint: endPoint, color: colors[0])
                
                context.saveGState()
                
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

            case 2:
                
                let center = CGPoint(x: bounds.midX, y: bounds.midY)
                let endPoint = CGPoint(x: bounds.maxX, y: bounds.midY)
                drawPath(path: path, context: context, pivotPoint: center, center: center, endPoint: endPoint, color: colors[0])
                
                context.saveGState()
                
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
                
            case 3:
                
                let center = CGPoint(x: bounds.midX, y: bounds.midY)
                let endPoint = CGPoint(x: bounds.midX, y: bounds.maxY)
                
                drawPath(path: path, context: context, pivotPoint: center, center: center, endPoint: endPoint, color: colors[0])
                
                context.saveGState()
                
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
                
            case 4:
                
                let center = CGPoint(x: bounds.midX, y: bounds.midY)
                let endPoint = CGPoint(x: bounds.minX, y: bounds.midY)
                drawPath(path: path, context: context, pivotPoint: center, center: center, endPoint: endPoint, color: colors[0])
                
                context.saveGState()
                
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
            
        case .blank:
            
            print()
        }
    }
    
    func drawPath(path: UIBezierPath, context: CGContext, pivotPoint: CGPoint, center: CGPoint, endPoint: CGPoint, color: CGColor) {
        
        context.saveGState()
        path.move(to: pivotPoint)
        path.addQuadCurve(to: endPoint, controlPoint: center)
        context.addPath(path.cgPath)
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
    case doubleElbow
    case entrance
    case exit
    case wall
    case pieceMaker
    case ball
    case blank
}





