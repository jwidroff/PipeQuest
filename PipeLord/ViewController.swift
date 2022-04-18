//
//  ViewController.swift
//  PipeLord
//
//  Created by Jeffery Widroff on 06/04/2022.
//

import UIKit

class ViewController: UIViewController {

    var model = Model()
    var pieceWidth = CGFloat()
    var pieceHeight = CGFloat()
    var boardWidth = CGFloat()
    var boardHeight = CGFloat()
    var piecesWereEnlarged = false
    var distanceFromPieceCenter = CGFloat()
    var deviceIsNarrow = Bool()
    var retryButton = UIButton()
    var menuButton = UIButton()
    var heightCushion = CGFloat()
    var colorTheme = ColorTheme()
    var boardView = UIView()
    var duration4Animation = 0.25
    var movesLeftLabel = UILabel()
    var movesLeftTextLabel = UILabel()
    var levelNameLabel = UILabel()
    var levelObjectiveLabel = UILabel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = colorTheme.gameBackground
        model = Model()
        model.delegate = self
//        model.showLoadingAnimation()
        
        
        
//        let delayedTime = DispatchTime.now() + .milliseconds(Int(5000))
//
//        DispatchQueue.main.asyncAfter(deadline: delayedTime) {
            
            self.model.board.view.removeFromSuperview()
            self.model.setUpGame()
            self.model.loadingMode = false
//        }
    }
    
    //MARK: Initial Setup
    func setupGrid() {

        let frameX = (self.model.board.view.frame.width - boardWidth) / 2
        let frameY = (self.model.board.view.frame.height - boardHeight) / 2
        let frame = CGRect(x: frameX, y: frameY, width: boardWidth, height: boardHeight)
        self.model.board.grid = GridPoints(frame: frame, height: self.model.board.heightSpaces, width: self.model.board.widthSpaces).getGrid()
    }
    
    func setupBoard(board: Board) {
        
        var frameY = CGFloat()
        
        if deviceIsNarrow {

            frameY = self.view.frame.midY - (boardHeight / 2) + (heightCushion / 4)
            
        } else {
            
            frameY = self.view.frame.midY - (boardHeight / 2)// + (heightCushion)
        }
        
        let frameX = self.view.frame.midX - (boardWidth / 2)
        let frame = CGRect(x: frameX, y: frameY, width: boardWidth, height: boardHeight)
        var xArray = [CGFloat]()
        var yArray = [CGFloat]()
        
        for point in self.model.board.grid.values {
                        
            if !xArray.contains(point.x) {
                
                xArray.append(point.x)
            }
            
            if !yArray.contains(point.y) {
                
                yArray.append(point.y)
            }
        }
        
        boardView = BoardView(frame: frame, xArray: xArray, yArray: yArray, iceLocations: model.board.iceLocations, holeLocations: model.board.holeLocations, colorTheme: board.colorTheme)
        self.model.board.view = boardView
        self.model.board.view.backgroundColor = colorTheme.boardBackground
        self.addSwipeGestureRecognizer(view: model.board.view)
        
        view.addSubview(self.model.board.view)
    }
    
    func setSizes() {

        heightCushion = self.view.frame.height / 5
        boardHeight = self.view.frame.height - heightCushion
        boardWidth = boardHeight / 2
        pieceWidth = boardWidth / CGFloat(model.board.widthSpaces) / 10 * 9
        pieceHeight = boardHeight / CGFloat(model.board.heightSpaces) / 10 * 9
        distanceFromPieceCenter = (pieceWidth / 8.5 * 10) / 2
        
    }
    
    func setupControls() {
        
        setupRetryButton()
        setupMenuButton()
        setupMovesLeftLabel()
        setupLevelNameLabel()
    }
    
    func makeViewSoft(view: UIView) {
        
        //TODO: This needs to be adjusted.
        view.layer.shadowOpacity = 1.0
        view.layer.masksToBounds = false

        let cornerRadius: CGFloat = view.frame.height / 2
        let shadowRadius: CGFloat = 3

        let darkShadow = CALayer()
        darkShadow.frame = view.bounds
        darkShadow.backgroundColor = view.backgroundColor?.cgColor
        darkShadow.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
        darkShadow.cornerRadius = cornerRadius
        darkShadow.shadowOffset = CGSize(width: shadowRadius, height: shadowRadius)
        darkShadow.shadowOpacity = 1
        darkShadow.shadowRadius = shadowRadius
        view.layer.insertSublayer(darkShadow, at: 0)

        let lightShadow = CALayer()
        lightShadow.frame = view.bounds
        lightShadow.backgroundColor = view.backgroundColor?.cgColor
        lightShadow.shadowColor = UIColor.black.cgColor
        lightShadow.cornerRadius = cornerRadius
        lightShadow.shadowOffset = CGSize(width: -shadowRadius, height: -shadowRadius)
        lightShadow.shadowOpacity = 1
        lightShadow.shadowRadius = shadowRadius
        view.layer.insertSublayer(lightShadow, at: 0)
    }
    
    func setupRetryButton() {
        
        let controlHeight = pieceHeight / 2
        let buttonWidth = (boardWidth / 2) - 10
        let buttonHeight = controlHeight
        
        let retryButtonYFloat = model.board.view.frame.maxY + (controlHeight / 2)
        let retryButtonXFloat = model.board.view.frame.minX + (boardWidth / 2) + 10
        let retryButtonFrame = CGRect(x: retryButtonXFloat, y: retryButtonYFloat, width: buttonWidth, height: buttonHeight)
        retryButton = UIButton(frame: retryButtonFrame)
        retryButton.layer.cornerRadius = retryButton.frame.height / 2
        retryButton.backgroundColor = colorTheme.buttonColors
        retryButton.setTitle("RETRY", for: .normal)
        retryButton.titleLabel?.adjustsFontSizeToFitWidth = true
        retryButton.setTitleColor(colorTheme.buttonTextColor, for: .normal)
        retryButton.addTarget(self, action: #selector(handleTap4Retry(sender:)), for: .touchUpInside)
        retryButton.showsTouchWhenHighlighted = true
        //        makeViewSoft(view: retryButton)
        view.addSubview(retryButton)
    }
    
    func setupMenuButton() {
        
        let controlHeight = pieceHeight / 2
        let buttonWidth = (boardWidth / 2) - 10
        let buttonHeight = controlHeight
        let menuButtonYFloat = model.board.view.frame.maxY + (controlHeight / 2)
        let menuButtonXFloat = model.board.view.frame.minX
        let menuButtonFrame = CGRect(x: menuButtonXFloat, y: menuButtonYFloat, width: buttonWidth, height: buttonHeight)
        menuButton = UIButton(frame: menuButtonFrame)
        menuButton.layer.cornerRadius = menuButton.frame.height / 2
        menuButton.backgroundColor = colorTheme.buttonColors
        menuButton.setTitle("MENU", for: .normal)
        menuButton.titleLabel?.adjustsFontSizeToFitWidth = true
        menuButton.setTitleColor(colorTheme.buttonTextColor, for: .normal)
        menuButton.addTarget(self, action: #selector(handleTap4Menu(sender:)), for: .touchUpInside)
        menuButton.showsTouchWhenHighlighted = true
        //        makeViewSoft(view: menuButton)
        view.addSubview(menuButton)
    }
    
    func setupMovesLeftLabel() {
        
        
        let controlHeight = pieceHeight / 2
        let movesLeftLabelHeight = controlHeight
        let movesLeftLabelWidth = (boardWidth / 2) - (controlHeight / 2)
        let swipesLeftYFloat = model.board.view.frame.minY - movesLeftLabelHeight
        let swipesLeftXFloat = model.board.view.frame.minX + (boardWidth / 2) + 10
        let movesLeftLabelFrame = CGRect(x: swipesLeftXFloat, y: swipesLeftYFloat, width: movesLeftLabelWidth, height: movesLeftLabelHeight)
        movesLeftLabel.frame = movesLeftLabelFrame
        movesLeftLabel.backgroundColor = .clear
        movesLeftLabel.textAlignment = .right
        view.addSubview(movesLeftLabel)
        
        
        let movesLeftTextLabelFrame = CGRect(x: swipesLeftXFloat - 30, y: swipesLeftYFloat, width: movesLeftLabelWidth, height: movesLeftLabelHeight)
        
        movesLeftTextLabel = UILabel(frame: movesLeftTextLabelFrame)
        
        
        movesLeftTextLabel.frame = movesLeftTextLabelFrame
        movesLeftTextLabel.backgroundColor = .clear
        movesLeftTextLabel.textAlignment = .right
        movesLeftTextLabel.text = "Moves left: "
        movesLeftTextLabel.textAlignment = .right
        view.addSubview(movesLeftTextLabel)
        
        
    }
    
    func setupLevelNameLabel() {
        
        let controlHeight = pieceHeight / 2
        let levelNameLabelHeight = controlHeight
        let levelNameLabelWidth = boardWidth
        let levelNameYFloat = model.board.view.frame.minY - levelNameLabelHeight
        let levelNameXFloat = model.board.view.frame.minX
        let levelNameLabelFrame = CGRect(x: levelNameXFloat, y: levelNameYFloat, width: levelNameLabelWidth, height: levelNameLabelHeight)
        levelNameLabel.frame = levelNameLabelFrame
        levelNameLabel.backgroundColor = .clear
        levelNameLabel.textAlignment = .left
        levelNameLabel.text = "[LEVEL NAME]"
        view.addSubview(levelNameLabel)
    }

    //MARK: Handle Functions
    
    @objc func handleSwipe(sender:UISwipeGestureRecognizer) {
        
        if model.board.moves > 0 || model.infiniteMoves == true {
            
            switch sender.direction {
                
            case .up:
                model.movePiece(direction: sender.direction)
                
            case .down:
                model.movePiece(direction: sender.direction)

            case .right:
                model.movePiece(direction: sender.direction)

            case .left:
                model.movePiece(direction: sender.direction)

            default:
                break
            }
//            if model.check4GameOver() == true {
//
//                runPopUpView(title: "You Lose", message: "No Pieces ")
//
//
//            }
        }
    }
    
    @objc func handleTap(sender:UITapGestureRecognizer) {
        
        let pieceCenter = sender.view?.center
        model.handleTap(center: pieceCenter!)
    }
    
    @objc func handleTap4Retry(sender: UITapGestureRecognizer) {
                        
        runPopUpView(title: "", message: "Are you sure you want to restart?")
    }
    
    @objc func handleTap4Menu(sender: UITapGestureRecognizer) {
        
        runMenuView()
    }
    
    func runMenuView() {
        
        //TODO: Finish this
        let width = self.view.frame.width / 10 * 9
        let height = self.view.frame.height / 10 * 9
        let x = (self.view.frame.width - width) / 2
        let y = (self.view.frame.height - height) / 2
        let frame = CGRect(x: x, y: y, width: width, height: height)
        let menuView = MenuView(frame: frame, model: model)
        view.addSubview(menuView)
    }

    func radians(degrees: Double) ->  CGFloat {
        
        return CGFloat(degrees * .pi / degrees)
    }
    
    //MARK: Ball functions
    
    func checkIfBallCanMove(direction: UISwipeGestureRecognizer.Direction, indexes: Indexes) -> Bool {
        
        var bool = Bool()

        switch direction {
            
        case .up:
            
            if model.board.pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x, y: indexes.y! - 1)
            }) {
                bool = true
            } else {
                bool = false
            }
            
        case .down:
            
            if model.board.pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x, y: indexes.y! + 1)
            }) {
                bool = true
            } else {
                bool = false
            }
            
        case .left:
            
            if model.board.pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x! - 1, y: indexes.y)
            }) {
                bool = true
            } else {
                bool = false
            }
            
        case .right:
            
            if model.board.pieces.contains(where: { (piece) -> Bool in
                piece.indexes == Indexes(x: indexes.x! + 1, y: indexes.y)
            }) {
                bool = true
            } else {
                bool = false
            }

        default:
            break
        }
        return bool
    }
    
    func animateMove(ball: Ball, endSide: String) {
                
        CATransaction.begin()
        
        CATransaction.setCompletionBlock {
                     
            CATransaction.begin()
            
            CATransaction.setCompletionBlock {
                
                ball.path = UIBezierPath()
                                
                switch endSide {
                
                case "top":
                    
                    self.model.moveBall(ball: ball, startSide: "bottom")
                    
                case "bottom":
                    
                    self.model.moveBall(ball: ball, startSide: "top")
                    
                case "left":
                    
                    self.model.moveBall(ball: ball, startSide: "right")
                    
                case "right":
                    
                    self.model.moveBall(ball: ball, startSide: "left")
                    
                default:
                    
                    break
                }
            }
            
            ball.view.center = ball.center
            
            CATransaction.commit()
        }
        
        setAnimation(ball: ball)
        
        CATransaction.commit()
    }
    
    func setAnimation(ball: Ball) {
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = ball.path.cgPath
        animation.repeatCount = 0
        animation.duration = duration4Animation
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        ball.view.layer.add(animation, forKey: "animate along path")
    }
}

extension ViewController: ModelDelegate {

    func addSwipeGestureRecognizer(view: UIView) {
        
        var upSwipe = UISwipeGestureRecognizer()
        var downSwipe = UISwipeGestureRecognizer()
        var rightSwipe = UISwipeGestureRecognizer()
        var leftSwipe = UISwipeGestureRecognizer()
        
        upSwipe = UISwipeGestureRecognizer(target: self, action: #selector( handleSwipe(sender:)))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
        
        downSwipe = UISwipeGestureRecognizer(target: self, action: #selector( handleSwipe(sender:)))
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
        
        rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector( handleSwipe(sender:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector( handleSwipe(sender:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
    }
    
    func addTapGestureRecognizer(view: UIView) {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        tap.numberOfTapsRequired = 1
        view.addGestureRecognizer(tap)
    }
    
    
    func updateMovesLeftLabel(moves: String) {
        
        movesLeftLabel.text = " \(moves)"
        
        if moves == "0" {
        
            movesLeftLabel.font = UIFont.boldSystemFont(ofSize: movesLeftLabel.font.pointSize)
            movesLeftLabel.textColor = UIColor.red
        
        } else if Int(moves) ?? 0 >= model.board.moves / 2 && Int(moves) ?? 0 <= 3 {
            
            if moves != "∞" {
                movesLeftLabel.font = UIFont.boldSystemFont(ofSize: movesLeftLabel.font.pointSize)
                movesLeftLabel.textColor = UIColor.purple
            }
        }
    }
    
    func updateLevelInfo(name: String, moves: String) {
        
        levelNameLabel.text = name.uppercased()
        
        var movesX = String()
        
        if moves == "0" {
            
            movesX = "∞"
            model.infiniteMoves = true
        } else {
            
            movesX = moves
            model.infiniteMoves = false
        }
        
        movesLeftLabel.text = " \(movesX)"
    }
    
    func changeAnimationSpeed(slowerOrFaster: String) {
        
        switch slowerOrFaster {
        
        case "faster":
            
            if duration4Animation > 0.02 {
                
                duration4Animation -= 0.02
            }
                        
        case "slower":
            
            duration4Animation = 0.25
            
        default:
            break
        }
    }
    
    func changeViewColor(piece: Piece, ball: Ball) {
        
        var backgroundColor = UIColor.systemYellow
        
        if ball.loopedIndexes[piece.indexes] == 1 {
            
            backgroundColor = UIColor.orange
            
        } else if ball.loopedIndexes[piece.indexes] == 2 {
            
            backgroundColor = UIColor.red

        } else if ball.loopedIndexes[piece.indexes] == 3 {
            
            backgroundColor = UIColor.purple

        } else if ball.loopedIndexes[piece.indexes] == 4 {
            
            backgroundColor = UIColor.systemIndigo
        } else if ball.loopedIndexes[piece.indexes] == 5 {
            
            backgroundColor = UIColor.orange
        } else if ball.loopedIndexes[piece.indexes] == 6 {
            
            backgroundColor = UIColor.red
        } else if ball.loopedIndexes[piece.indexes] == 7 {
            
            backgroundColor = UIColor.purple
        } else if ball.loopedIndexes[piece.indexes] == 8 {
            
            backgroundColor = UIColor.systemIndigo
        } else if ball.loopedIndexes[piece.indexes] == 9 {
            
            backgroundColor = UIColor.orange
        } else if ball.loopedIndexes[piece.indexes] == 10 {
            
            backgroundColor = UIColor.systemIndigo
        }
        
        piece.view.backgroundColor = backgroundColor
        
        let delayedTime = DispatchTime.now() + .milliseconds(Int(250))

        DispatchQueue.main.asyncAfter(deadline: delayedTime) {
            
            piece.view.backgroundColor = .clear
        }
    }
    
    func replacePieceView(piece: Piece) {
        
        if self.model.board.pieces.contains(where: { (pieceX) -> Bool in
            pieceX.indexes == piece.indexes
        }) {
            
            
            let newPiece = Piece(indexes: piece.indexes, shape: piece.shape, colors: piece.colors, version: piece.version, currentSwitch: piece.currentSwitch, isLocked: piece.isLocked, opening: piece.opening, doesPivot: piece.doesPivot)
            
            let frame = CGRect(x: self.model.board.grid[piece.indexes]!.x - (self.pieceWidth / 2), y:  self.model.board.grid[piece.indexes]!.y - (self.pieceHeight / 2), width: self.pieceWidth, height: self.pieceHeight)
            
            let shapeView = ShapeView(frame: frame, piece: newPiece)
            piece.view.removeFromSuperview()
            piece.view = shapeView
            self.addTapGestureRecognizer(view: piece.view)
            self.model.board.view.addSubview(piece.view)
            
            for ball in self.model.board.balls {
                
                self.model.board.view.bringSubviewToFront(ball.view)
            }
        }
    }
    
    func crashBallViewIntoCross(piece: Piece, ball: Ball) {
        
        let yAxisIsAligned:Bool = piece.view.frame.minY + (piece.view.frame.height / 2) == ball.center.y
        let xAxisIsAligned:Bool = piece.view.frame.minX + (piece.view.frame.width / 2) == ball.center.x
        let ballIsLowerTanPieceCenter:Bool = piece.view.frame.minY + (piece.view.frame.height / 2) < ball.center.y
        let ballIsHigherThanPieceCenter:Bool = piece.view.frame.minY + (piece.view.frame.height / 2) > ball.center.y
        let ballIsRightOfPieceCenter = piece.view.frame.minX + (piece.view.frame.width / 2) < ball.center.x
        let ballIsLeftOfPieceCenter = piece.view.frame.minX + (piece.view.frame.width / 2) > ball.center.x
        var startPoint = CGPoint()
        var endPoint = CGPoint()

        if xAxisIsAligned && ballIsLowerTanPieceCenter {
            
            //Moves the piece up
             startPoint = CGPoint(x: ball.center.x, y: ball.center.y - (self.pieceWidth / 2))
             endPoint = CGPoint(x: ball.center.x, y: ball.center.y - (self.pieceHeight / 3))
            
        } else if xAxisIsAligned && ballIsHigherThanPieceCenter {
            
            //Moves the piece down
             startPoint = CGPoint(x: ball.center.x, y: ball.center.y + (self.pieceWidth / 2))
             endPoint = CGPoint(x: ball.center.x, y: ball.center.y + (self.pieceHeight / 3))
            
        } else if yAxisIsAligned && ballIsRightOfPieceCenter {
            
            //Moves the piece left
             startPoint = CGPoint(x: ball.center.x - (self.pieceWidth / 2), y: ball.center.y)
             endPoint = CGPoint(x: ball.center.x - (self.pieceWidth / 3), y: ball.center.y)
            
        } else if yAxisIsAligned && ballIsLeftOfPieceCenter {
            
            //Moves the ball right
             startPoint = CGPoint(x: ball.center.x + (self.pieceWidth / 2), y: ball.center.y)
             endPoint = CGPoint(x: ball.center.x + (self.pieceWidth / 3), y: ball.center.y)
        }
        
        UIView.animate(withDuration: 0.125) {
            
            let transform = CGAffineTransform(translationX: (startPoint.x - endPoint.x) * 2, y: (startPoint.y - endPoint.y) * 2)
            ball.view.transform = transform
            
        } completion: { (true) in
            print()
        }
    }
    
    func removeView(view: UIView) {
        
        self.model.board.view.layer.mask?.shadowOpacity = 0.2
        model.board.view.bringSubviewToFront(view)
        
        
//        model.board.view.insertSubview(view, at: 10)
        
        let scale = CGAffineTransform(scaleX: 0.01, y: 0.01)
        let delayedTime = DispatchTime.now() + .milliseconds(Int(250))

        DispatchQueue.main.asyncAfter(deadline: delayedTime) {
            
            
            
            UIView.animate(withDuration: self.duration4Animation, delay: 0.0, options: .curveEaseInOut) {
                
                self.model.board.view.layer.mask?.shadowOpacity = 0.1
                
                
                self.model.board.view.bringSubviewToFront(view)
                
                
                view.transform = scale
                
                

            } completion: { (true) in

                view.removeFromSuperview()
            }
        }
    }
    
    func removeHole(indexes: Indexes) {
        
        for subview in model.board.view.subviews {

            let centerX = self.model.board.grid[indexes]
            let pieceCenter = CGPoint(x: centerX!.x.rounded(), y: centerX!.y.rounded())
            
            let subviewCenter = CGPoint(x: subview.center.x.rounded(), y: subview.center.y.rounded())

            if subviewCenter  == pieceCenter {
                    let piece = self.model.getPieceInfo(index: indexes)
                    self.removeView(view: subview)
                    self.removeView(view: piece.view)
                    self.model.deletePiece(piece: piece)

                return
            }
        }
    }
    
    func resetPieceMakerView(piece: Piece) {
 
        let frame = piece.view.subviews.first!.frame
        let nextPieceView = ShapeView(frame: frame, piece: piece.nextPiece!)
        
//        nextPieceView.layer.shadowPath.r
//
//        nextPieceView.layer.shadowOpacity = 0
        
        
        
        
        piece.view.subviews.first!.removeFromSuperview()
        piece.view.addSubview(nextPieceView)
    }
    
    func addPieceView(piece: Piece) {
        
        piece.center = self.model.board.grid[piece.indexes]!
        piece.view.center = piece.center
        
        if piece.shape != .pieceMaker {
            
            addTapGestureRecognizer(view: piece.view)
        }
        
        UIView.animate(withDuration: 0.25) {
            let rect = CGRect(x: piece.view.frame.minX, y: piece.view.frame.minY, width: self.pieceWidth, height: self.pieceHeight)
            piece.view.frame = rect
            self.model.board.view.addSubview(piece.view)
        }
    }

    func moveBallView(ball: Ball, piece: Piece, startSide: String, endSide: String) {
        
        model.board.view.gestureRecognizers?.removeAll()
        
        var beginPoint = CGPoint()
        var endPoint = CGPoint()
        var controlPoint = CGPoint()
        self.model.board.view.bringSubviewToFront(ball.view)
        
        switch startSide {
        
        case "center":
            
            if endSide == "left" {
                
                endPoint = CGPoint(x: piece.center.x - self.distanceFromPieceCenter, y: piece.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! - 1, y: ball.indexes.y!)
                
            } else if endSide == "right" {
                
                endPoint = CGPoint(x: piece.center.x + self.distanceFromPieceCenter, y: piece.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! + 1, y: ball.indexes.y!)
                
            } else if endSide == "top"{
                
                endPoint = CGPoint(x: piece.center.x, y: piece.center.y - self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! - 1)
                
            } else if endSide == "bottom" {
                
                endPoint = CGPoint(x: piece.center.x, y: piece.center.y + self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! + 1)
            }
            
            beginPoint = ball.center
            
        case "top":
            
            if endSide == "left" {
                
                endPoint = CGPoint(x: piece.center.x - self.distanceFromPieceCenter, y: piece.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! - 1, y: ball.indexes.y!)
                
            } else if endSide == "right" {
                
                endPoint = CGPoint(x: piece.center.x + self.distanceFromPieceCenter, y: piece.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! + 1, y: ball.indexes.y!)
                
            } else if endSide == "bottom" {
                
                endPoint = CGPoint(x: piece.center.x, y: piece.center.y + self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! + 1)
                
            } else if endSide == "center" {
                
                endPoint = CGPoint(x: piece.center.x, y: piece.center.y)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y!)
            }
            
            beginPoint = ball.center
            
        case "bottom":
            
            if endSide == "left" {
                
                endPoint = CGPoint(x: piece.center.x - self.distanceFromPieceCenter, y: piece.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! - 1, y: ball.indexes.y!)
                
            } else if endSide == "right" {
                
                endPoint = CGPoint(x: piece.center.x + self.distanceFromPieceCenter, y: piece.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! + 1, y: ball.indexes.y!)
                
            } else if endSide == "top" {
                
                endPoint = CGPoint(x: piece.center.x, y: piece.center.y - self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! - 1)
                
            } else if endSide == "center" {
                
                endPoint = CGPoint(x: piece.center.x, y: piece.center.y)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y!)
            }
            
            beginPoint = ball.center
            
        case "left":
            
            if endSide == "bottom" {
                
                endPoint = CGPoint(x: piece.center.x, y: piece.center.y + self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! + 1)
                
            } else if endSide == "top" {
                
                endPoint = CGPoint(x: piece.center.x, y: piece.center.y - self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! - 1)
                
            } else if endSide == "right" {
                
                endPoint = CGPoint(x: piece.center.x + self.distanceFromPieceCenter, y: piece.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! + 1, y: ball.indexes.y!)
                
            } else if endSide == "center" {
                
                endPoint = CGPoint(x: piece.center.x, y: piece.center.y)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y!)
            }
            
            beginPoint = ball.center
            
        case "right":
                        
            if endSide == "bottom" {
                
                endPoint = CGPoint(x: piece.center.x, y: piece.center.y + self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! + 1)
                
            } else if endSide == "top" {
                
                endPoint = CGPoint(x: piece.center.x, y: piece.center.y - self.distanceFromPieceCenter)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y! - 1)
                
            } else if endSide == "left" {
                
                endPoint = CGPoint(x: piece.center.x - self.distanceFromPieceCenter, y: piece.center.y)
                ball.indexes = Indexes(x: ball.indexes.x! - 1, y: ball.indexes.y!)
                
            } else if endSide == "center" {
                
                endPoint = CGPoint(x: piece.center.x, y: piece.center.y)
                ball.indexes = Indexes(x: ball.indexes.x!, y: ball.indexes.y!)
            }
            
            beginPoint = ball.center
            
        default:
            break
        }
        
        controlPoint = piece.center
        ball.path.move(to: CGPoint(x: beginPoint.x, y: beginPoint.y))
        ball.path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        ball.center = endPoint
        animateMove(ball: ball, endSide: endSide)
    }
    
    func movePieceView(piece: Piece) {
        
        
        
        if piece.indexes.x! < 0{
            
            UIView.animate(withDuration: 0.25) {
                piece.center = CGPoint(x: piece.center.x - (self.distanceFromPieceCenter * 2), y: piece.center.y)
                piece.view.center = piece.center
            }
            
            self.model.deletePiece(piece: piece)
            
        } else if piece.indexes.x! > self.model.board.widthSpaces - 1 {
            
            UIView.animate(withDuration: 0.25) {
                piece.center = CGPoint(x: piece.center.x + (self.distanceFromPieceCenter * 2), y: piece.center.y)
                piece.view.center = piece.center

            }
            
            self.model.deletePiece(piece: piece)
            
        } else if piece.indexes.y! < 0 {
            
            UIView.animate(withDuration: 0.25) {
                piece.center = CGPoint(x: piece.center.x, y: piece.center.y - (self.distanceFromPieceCenter * 2))
                piece.view.center = piece.center

            }
            
            self.model.deletePiece(piece: piece)
            
        } else if piece.indexes.y! > self.model.board.heightSpaces - 1 {
            
            UIView.animate(withDuration: 0.25) {
                piece.center = CGPoint(x: piece.center.x, y: piece.center.y + (self.distanceFromPieceCenter * 2))
                piece.view.center = piece.center

            }
            
            self.model.deletePiece(piece: piece)
            
        } else {
            
            //Piece is on the board and therefore execute move regularly
            UIView.animate(withDuration: 0.25) {
                piece.center = self.model.board.grid[piece.indexes]!
                piece.view.center = piece.center
                
                for ball in self.model.board.balls {
                    if ball.indexes == piece.indexes {
                        
                        ball.view.center = self.model.board.grid[ball.indexes]!
                    }
                }
            }
        }
        
        if piece.shape == .entrance {
            
            for ball in model.board.balls {
                
                if ball.indexes == piece.indexes {
                    
                    UIView.animate(withDuration: 0.25) {
                        
                        ball.center = piece.center
                        ball.view.center = ball.center

                        self.model.deleteBall(ball: ball)
                        
                    } completion: { (true) in
                        print()
                    }
                }
            }
        }
    }
    
    func setUpPiecesView() {
        
        let center = CGPoint(x: (self.boardWidth / 2) - (pieceWidth / 2), y: self.boardHeight / 2 - (pieceHeight / 2))
        
        print("Set up pieces view called")
        
        UIView.animate(withDuration: 0.25, delay: 0.25, options: .curveEaseInOut) {  [self] in
            
            for piece in model.board.pieces {
            
                
                let frame = CGRect(x: center.x, y: center.y, width: pieceWidth, height: pieceHeight)

//                let frame = CGRect(x: 0, y: 0, width: pieceWidth, height: pieceHeight)
                piece.view = ShapeView(frame: frame, piece: piece)
                piece.center = CGPoint(x: model.board.grid[piece.indexes]?.x ?? piece.center.x, y: model.board.grid[piece.indexes]?.y ?? piece.center.y)
                
                
                piece.view.center = piece.center
                if piece.shape != .pieceMaker {
                    addTapGestureRecognizer(view: piece.view)

                }
                model.board.view.addSubview(piece.view)
            }
            setUpBallsView()
            
        } completion: { (false) in
            print()
        }
    }
    
    func setUpBallsView() {
        
        let center = CGPoint(x: (self.boardWidth / 2) - (pieceWidth / 2), y: self.boardHeight / 2 - (pieceHeight / 2))
                
        for ball in self.model.board.balls {
            
            let frame = CGRect(x: center.x, y: center.y, width: pieceWidth, height: pieceHeight)
            ball.view = BallView(frame: frame)
            ball.center = CGPoint(x: model.board.grid[ball.indexes]?.x ?? ball.view.center.x, y: model.board.grid[ball.indexes]?.y ?? ball.view.center.y)
            ball.view.center = ball.center
            addTapGestureRecognizer(view: ball.view)
            self.model.board.view.addSubview(ball.view)
        }
    }
    
    func runPopUpView(title: String, message: String) {
        
        if model.gameOver == true {
            model.gameOver = false
            return
        }
        
        let delayedTime = DispatchTime.now() + .milliseconds(Int(500))
        
        DispatchQueue.main.asyncAfter(deadline: delayedTime) {
        
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { (action) in
                alert.dismiss(animated: true) {
                    
                    if title == "YOU WIN" {
                        self.model.level.number += 1
                        self.model.updateUserDefaults()
                    }
                    
                    self.movesLeftLabel.textColor = UIColor.black
                    
                    self.model.resetGame()
                    
                    let delayedTime = DispatchTime.now() + .milliseconds(Int(25))
                    DispatchQueue.main.asyncAfter(deadline: delayedTime) {

                        self.removeViews()
                        
                        DispatchQueue.main.asyncAfter(deadline: delayedTime + 0.25) {
                            //Add code here if you want something to happen after the first wait
                        }
                    }
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (cancelAction) in
                alert.dismiss(animated: true) {
                    
                    self.model.gameOver = false
                }
            }
            alert.addAction(action)
            alert.addAction(cancelAction)
            self.present(alert, animated: true) {
                //completion here
            }
        }
    }
    
    func removeViews() {
        
        self.boardView.removeFromSuperview()
        self.retryButton.removeFromSuperview()
        self.menuButton.removeFromSuperview()
        self.movesLeftLabel.removeFromSuperview()
        self.movesLeftTextLabel.removeFromSuperview()
        self.model.setUpGame()
    }
    
    func setUpGameViews(board: Board) {
                
        self.setSizes()
        self.setupGrid()
        self.setupBoard(board: board)
    }
    
    func setUpControlViews() {
        self.setupControls()
    }
    
    func clearPiecesAnimation(view: UIView) {
        
        UIView.animate(withDuration: 0.25) {
            
            let center = CGPoint(x: self.boardWidth / 2, y: self.boardHeight / 2)
            
            let translationX = center.x - view.center.x
            
            let translationY = center.y - view.center.y
            
            
            
            
//            let translationX = self.model.board.grid[Indexes(x: 0, y: 0)]!.x - view.center.x
//
//            let translationY = self.model.board.grid[Indexes(x: 0, y: 0)]!.x - view.center.y
            
            let transform = CGAffineTransform(translationX: translationX, y: translationY)
            
            view.transform = transform
            
        } completion: { (true) in
            print()
        }
    }
}






