//
//  ViewController.swift
//  Tic-Tac-Toe
//
//  Created by Alex Richards on 2/6/18.
//  Copyright © 2018 Alex Richards. All rights reserved.
//http://www.cybercomputing.co.uk/ICT/Adobe/Flash/tictactoe/TicTacToe.html, http://icons.mysitemyway.com/legacy-icon/074201-rounded-glossy-black-icon-////alphanumeric-x-mark/, http://canacopegdl.com/synonym/o.html, https://icons8.com/icon/set/3-in-a-row/all, http://www.appsapk.com/tic-tac-toe-pro/, https://en.wiktionary.org/wiki/o

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var grid: UIImageView!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var player1: UILabel!
    @IBOutlet weak var player2: UILabel!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var view8: UIView!
    @IBOutlet weak var view9: UIView!
    
    var oPiece: UIImageView!
    var xPiece: UIImageView!
    var infoButton: UIButton!
    var info: UITextView!
    var fullInfoScreen: UIView!
    var winningLine: LineView!
    
    var currentPlayer = 2
    var spotTaken = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    var winnerRows = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    var gameIsActive = true
    var backgroundMusicPlayer: AVAudioPlayer?
    var winningPlayer = 0
    var dismiss = UIButton()
    var infoText: UITextView!
    var viewsArray: [UIView] = []
    var xPiecesArray: [UIImageView] = []
    var oPiecesArray: [UIImageView] = []
    
    let turnSound = Bundle.main.path(forResource: "notification-beep", ofType: "wav")!
    let occupiedSound = Bundle.main.path(forResource: "firing", ofType: "wav")!
    let placedSound = Bundle.main.path(forResource: "Ping", ofType: "aiff")!
    let winSound = Bundle.main.path(forResource: "Glass", ofType: "aiff")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view1.alpha = 0
        view2.alpha = 0
        view3.alpha = 0
        view4.alpha = 0
        view5.alpha = 0
        view6.alpha = 0
        view7.alpha = 0
        view8.alpha = 0
        view9.alpha = 0
        viewsArray = [view1, view2, view3, view4, view5, view6, view7, view8, view9]
        
        // set up the game board
        gameTitle.text = "Tic-Tac-Toe"
        player1.text = "<-- Player 1"
        player2.text = "Player 2 -->"
        
        //initialize the first pieces and set X as the first turn
        newXPiece()
        newOPiece()
        changeTurns()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Pan Gesture for O's.
    @IBAction func moveO(_ sender: UIPanGestureRecognizer){
        if currentPlayer == 2{
            var didLand = true
            let movement = sender.translation(in: self.view)
            
            if let viewPiece = sender.view {
                viewPiece.center = CGPoint(x:viewPiece.center.x + movement.x, y:viewPiece.center.y + movement.y)
                if sender.state == .began{
                    playSound(sound: turnSound)
                }
                if sender.state == .ended{
                    if viewPiece.frame.minX > view1.frame.minX  && viewPiece.frame.minX < (view1.frame.minX + view1.frame.width) && viewPiece.frame.minY > view1.frame.minY && viewPiece.frame.minY < (view1.frame.minY + view1.frame.height) && spotTaken[0] == 0{
                        viewPiece.center = view1.center
                        spotTaken[0] = 2
                        removeGesture(piece: viewPiece as! UIImageView)
                    }
                    else if viewPiece.frame.minX > view2.frame.minX  && viewPiece.frame.minX < (view2.frame.minX + view2.frame.width) && viewPiece.frame.minY > view2.frame.minY && viewPiece.frame.minY < (view2.frame.minY + view2.frame.height) && spotTaken[1] == 0{
                        viewPiece.center = view2.center
                        spotTaken[1] = 2
                        removeGesture(piece: viewPiece as! UIImageView)
                    }
                    else if viewPiece.frame.minX > view3.frame.minX  && viewPiece.frame.minX < (view3.frame.minX + view3.frame.width) && viewPiece.frame.minY > view3.frame.minY && viewPiece.frame.minY < (view3.frame.minY + view3.frame.height) && spotTaken[2] == 0{
                        viewPiece.center = view3.center
                        spotTaken[2] = 2
                        removeGesture(piece: viewPiece as! UIImageView)
                    }
                    else if viewPiece.frame.minX > view4.frame.minX  && viewPiece.frame.minX < (view4.frame.minX + view4.frame.width) && viewPiece.frame.minY > view4.frame.minY && viewPiece.frame.minY < (view4.frame.minY + view4.frame.height) && spotTaken[3] == 0{
                        viewPiece.center = view4.center
                        spotTaken[3] = 2
                        removeGesture(piece: viewPiece as! UIImageView)
                    }
                    else if viewPiece.frame.minX > view5.frame.minX  && viewPiece.frame.minX < (view5.frame.minX + view5.frame.width) && viewPiece.frame.minY > view5.frame.minY && viewPiece.frame.minY < (view5.frame.minY + view5.frame.height) && spotTaken[4] == 0{
                        viewPiece.center = view5.center
                        spotTaken[4] = 2
                        removeGesture(piece: viewPiece as! UIImageView)
                    }
                    else if viewPiece.frame.minX > view6.frame.minX  && viewPiece.frame.minX < (view6.frame.minX + view6.frame.width) && viewPiece.frame.minY > view6.frame.minY && viewPiece.frame.minY < (view6.frame.minY + view6.frame.height) && spotTaken[5] == 0{
                        viewPiece.center = view6.center
                        spotTaken[5] = 2
                        removeGesture(piece: viewPiece as! UIImageView)
                    }
                    else if viewPiece.frame.minX > view7.frame.minX  && viewPiece.frame.minX < (view7.frame.minX + view7.frame.width) && viewPiece.frame.minY > view7.frame.minY && viewPiece.frame.minY < (view7.frame.minY + view7.frame.height) && spotTaken[6] == 0{
                        viewPiece.center = view7.center
                        spotTaken[6] = 2
                        removeGesture(piece: viewPiece as! UIImageView)
                    }
                    else if viewPiece.frame.minX > view8.frame.minX  && viewPiece.frame.minX < (view8.frame.minX + view8.frame.width) && viewPiece.frame.minY > view8.frame.minY && viewPiece.frame.minY < (view8.frame.minY + view8.frame.height) && spotTaken[7] == 0{
                        viewPiece.center = view8.center
                        spotTaken[7] = 2
                        removeGesture(piece: viewPiece as! UIImageView)
                    }
                    else if viewPiece.frame.minX > view9.frame.minX  && viewPiece.frame.minX < (view9.frame.minX + view9.frame.width) && viewPiece.frame.minY > view9.frame.minY && viewPiece.frame.minY < (view9.frame.minY + view9.frame.height) && spotTaken[8] == 0{
                        viewPiece.center = view9.center
                        spotTaken[8] = 2
                        removeGesture(piece: viewPiece as! UIImageView)
                    }
                    else {
                        viewPiece.frame = CGRect(x: 261, y: 539, width: viewPiece.frame.width, height: viewPiece.frame.height)
                        didLand = false
                        playSound(sound: occupiedSound)
                    }
                    if didLand == true{
                        playSound(sound: placedSound)
                        winningMove()
                        boardFull()
                        newOPiece()
                        changeTurns()
                        
                    }
                }
            }
            sender.setTranslation(CGPoint.zero, in: self.view)
        }
    }
    
    @IBAction func moveX(_ sender: UIPanGestureRecognizer){
        if currentPlayer == 1{
            var didLand = true
            let movement = sender.translation(in: self.view)
            
            if let viewPiece = sender.view {
                viewPiece.center = CGPoint(x:viewPiece.center.x + movement.x, y:viewPiece.center.y + movement.y)
                if sender.state == .began{
                    playSound(sound: turnSound)
                }
                if sender.state == .ended{
                    if viewPiece.frame.minX > view1.frame.minX  && viewPiece.frame.minX < (view1.frame.minX + view1.frame.width) && viewPiece.frame.minY > view1.frame.minY && viewPiece.frame.minY < (view1.frame.minY + view1.frame.height) && spotTaken[0] == 0{
                        viewPiece.center = view1.center
                        spotTaken[0] = 1
                        removeGesture(piece: viewPiece as! UIImageView)
                    }
                    else if viewPiece.frame.minX > view2.frame.minX  && viewPiece.frame.minX < (view2.frame.minX + view2.frame.width) && viewPiece.frame.minY > view2.frame.minY && viewPiece.frame.minY < (view2.frame.minY + view2.frame.height) && spotTaken[1] == 0{
                        viewPiece.center = view2.center
                        spotTaken[1] = 1
                        removeGesture(piece: viewPiece as! UIImageView)
                    }
                    else if viewPiece.frame.minX > view3.frame.minX  && viewPiece.frame.minX < (view3.frame.minX + view3.frame.width) && viewPiece.frame.minY > view3.frame.minY && viewPiece.frame.minY < (view3.frame.minY + view3.frame.height) && spotTaken[2] == 0{
                        viewPiece.center = view3.center
                        spotTaken[2] = 1
                        removeGesture(piece: viewPiece as! UIImageView)
                    }
                    else if viewPiece.frame.minX > view4.frame.minX  && viewPiece.frame.minX < (view4.frame.minX + view4.frame.width) && viewPiece.frame.minY > view4.frame.minY && viewPiece.frame.minY < (view4.frame.minY + view4.frame.height) && spotTaken[3] == 0{
                        viewPiece.center = view4.center
                        spotTaken[3] = 1
                        removeGesture(piece: viewPiece as! UIImageView)
                    }
                    else if viewPiece.frame.minX > view5.frame.minX  && viewPiece.frame.minX < (view5.frame.minX + view5.frame.width) && viewPiece.frame.minY > view5.frame.minY && viewPiece.frame.minY < (view5.frame.minY + view5.frame.height) && spotTaken[4] == 0{
                        viewPiece.center = view5.center
                        spotTaken[4] = 1
                        removeGesture(piece: viewPiece as! UIImageView)
                    }
                    else if viewPiece.frame.minX > view6.frame.minX  && viewPiece.frame.minX < (view6.frame.minX + view6.frame.width) && viewPiece.frame.minY > view6.frame.minY && viewPiece.frame.minY < (view6.frame.minY + view6.frame.height) && spotTaken[5] == 0{
                        viewPiece.center = view6.center
                        spotTaken[5] = 1
                        removeGesture(piece: viewPiece as! UIImageView)
                    }
                    else if viewPiece.frame.minX > view7.frame.minX  && viewPiece.frame.minX < (view7.frame.minX + view7.frame.width) && viewPiece.frame.minY > view7.frame.minY && viewPiece.frame.minY < (view7.frame.minY + view7.frame.height) && spotTaken[6] == 0{
                        viewPiece.center = view7.center
                        spotTaken[6] = 1
                        removeGesture(piece: viewPiece as! UIImageView)
                    }
                    else if viewPiece.frame.minX > view8.frame.minX  && viewPiece.frame.minX < (view8.frame.minX + view8.frame.width) && viewPiece.frame.minY > view8.frame.minY && viewPiece.frame.minY < (view8.frame.minY + view8.frame.height) && spotTaken[7] == 0{
                        viewPiece.center = view8.center
                        spotTaken[7] = 1
                        removeGesture(piece: viewPiece as! UIImageView)
                    }
                    else if viewPiece.frame.minX > view9.frame.minX  && viewPiece.frame.minX < (view9.frame.minX + view9.frame.width) && viewPiece.frame.minY > view9.frame.minY && viewPiece.frame.minY < (view9.frame.minY + view9.frame.height) && spotTaken[8] == 0{
                        viewPiece.center = view9.center
                        spotTaken[8] = 1
                        removeGesture(piece: viewPiece as! UIImageView)
                    }
                    else {
                        viewPiece.frame = CGRect(x: 33, y: 539, width: viewPiece.frame.width, height: viewPiece.frame.height)
                        didLand = false
                        playSound(sound: occupiedSound)
                    }
                    if didLand == true{
                        playSound(sound: placedSound)
                        winningMove()
                        boardFull()
                        newXPiece()
                        changeTurns()
                    }
                }
            }
        sender.setTranslation(CGPoint.zero, in: self.view)
        }
    }
    
    //MARK: End of Game
    
    //runs through the winning row combinations to see if there is a winner of the game
    func winningMove(){
        var start = 0
        var end = 0
        for row in winnerRows{
            if spotTaken[row[0]] != 0 && spotTaken[row[0]] == spotTaken[row[1]] && spotTaken[row[1]] == spotTaken[row[2]] {
                winningPlayer = spotTaken[row[0]]
                gameIsActive = false
                print("winner: \(winningPlayer)")
                start = row[0]
                end = row[2]
            }
        }
        if winningPlayer != 0 {
            drawWinningLine(start: viewsArray[start].center, end: viewsArray[end].center)
            playSound(sound: winSound)
            gameOver()
        }
    }
    
    //checks if all the board spots are full without a winner declared
    func boardFull(){
        var boardCount = 0
        for spot in spotTaken{
            if spot != 0{
                boardCount += 1
            }
        }
        if boardCount == 9{
            gameOver()
        }
    }
    
    //Resets the board and removes prior game pieces
    func playAgain(){
        for x in xPiecesArray{
            x.removeFromSuperview()
        }
        for o in oPiecesArray{
            o.removeFromSuperview()
        }
        if winningPlayer != 0 {
            winningLine.removeFromSuperview()}
        xPiecesArray = []
        oPiecesArray = []
        gameIsActive = true
        currentPlayer = 2
        winningPlayer = 0
        spotTaken = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        newXPiece()
        newOPiece()
        changeTurns()
    }
    
    //creates pop up alert to mark the game end and ask if want to play again
    func gameOver(){
        var message = " "
        if winningPlayer == 1{
            message = "Player 1 Wins!"
        }
        else if winningPlayer == 2{ message = "Player 2 Wins!"}
        else {message = "It's a Draw" }
        let gameOverPopUp = UIAlertController(title: "Game Over",
                                              message: message,
                                              preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Play Again", style: .default, handler: {action in self.playAgain()})
        gameOverPopUp.addAction(alertAction)
        present(gameOverPopUp, animated: true, completion: nil)
    }
    
    //creates the line across the winning row
    func drawWinningLine(start: CGPoint, end: CGPoint){
        let rect = CGRect(x: 0, y: 0, width: 375, height: 667)
        winningLine = LineView(frame: rect, start: start, end: end)
        winningLine.isOpaque = false
        self.view.addSubview(winningLine)
    }
    
    //MARK: Game Info
    
    //creates the info screen and drops it down from the top onto the screen
    @IBAction func infoScreen(_ sender: UIButton){
        let rect1 = CGRect(x: 0, y: -410, width: 375, height: 410)
        let rect = CGRect(x: 0, y: 10, width: 375, height: 350)
        fullInfoScreen = UIView(frame: rect1)
        infoText = UITextView(frame: rect)
        infoText.text = "Tic-tac-toe is a game for two players, X and O, who take turns marking the spaces in a 3×3 grid. The player who succeeds in placing three of their marks in a horizontal, vertical, or diagonal row wins the game. Player X is always first."
        infoText.backgroundColor = UIColor.darkGray
        infoText.font = UIFont(name: "Helvetica Neue", size: 24)
        infoText.textColor = UIColor.white
        infoText.textAlignment = NSTextAlignment.center
        dismiss.setTitle("Dismiss", for: .normal)
        dismiss.addTarget(self, action: #selector(self.dismissInfo(_:)), for: .touchUpInside)
        dismiss.frame = CGRect(x: 0, y: 360, width: 375, height: 50)
        dismiss.backgroundColor = UIColor.lightGray
        dismiss.setTitleColor(UIColor.white, for: .normal)
        fullInfoScreen.addSubview(infoText)
        fullInfoScreen.addSubview(dismiss)
        self.view.addSubview(fullInfoScreen)
        UIView.animate(withDuration: 1.5, animations: {self.fullInfoScreen.frame = CGRect(x: 0, y: 0, width: 375, height: 410)})
    }
    
    //removes info screen, drops off bottom
    @IBAction func dismissInfo(_ sender: UIButton){
        UIView.animate(withDuration: 1.5, animations: {self.fullInfoScreen.frame = CGRect(x: 0, y: 668, width: 375, height: 410)})
    }
    
    //MARK: New Pieces
    
    //create O's that are waiting for turn, with gesture off and faded
    func newXPiece (){
        xPiece = UIImageView(frame: CGRect(x: 33, y: 539, width: 89, height: 124))
        xPiece.image = #imageLiteral(resourceName: "player-x")
        xPiece.alpha = 0.5
        let panGesture = UIPanGestureRecognizer(target: self, action:(#selector(self.moveX(_:))))
        xPiece.isUserInteractionEnabled = false
        xPiece.addGestureRecognizer(panGesture)
        self.view.addSubview(xPiece)
        xPiecesArray.append(xPiece)
    }
    
    //create O's that are waiting for turn, with gesture off and faded
    func newOPiece (){
        oPiece = UIImageView(frame: CGRect(x: 261, y: 539, width: 89, height: 124))
        oPiece.image = #imageLiteral(resourceName: "Image O")
        oPiece.alpha = 0.5
        let panGesture = UIPanGestureRecognizer(target: self, action:(#selector(self.moveO(_:))))
        oPiece.isUserInteractionEnabled = false
        oPiece.addGestureRecognizer(panGesture)
        self.view.addSubview(oPiece)
        oPiecesArray.append(oPiece)
    }
    
    //removes the gesture once a piece is droppped on the board to lock it in place
    func removeGesture(piece: UIImageView){
        piece.gestureRecognizers?.forEach(piece.removeGestureRecognizer)
    }
    
    //change turn after piece is placed on the board. Turns gesture on, darkens the piece in action and animates it.
    func changeTurns(){
        if currentPlayer == 1{
            oPiece.isUserInteractionEnabled = true
            oPiece.alpha = 1
            UIView.animate(withDuration: 0.5, animations: {self.oPiece.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)})
            UIView.animate(withDuration: 0.5, animations: {self.oPiece.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)})
            currentPlayer = 2
        }
        else if currentPlayer == 2{
            xPiece.isUserInteractionEnabled = true
            xPiece.alpha = 1
            UIView.animate(withDuration: 0.5, animations: {self.xPiece.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)})
            UIView.animate(withDuration: 0.5, animations: {self.xPiece.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)})
            currentPlayer = 1
        }
    }
    
    //MARK: Audio Player
    
    //create audio player to insert sounds
    func playSound(sound: String){
        do{
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound), fileTypeHint: AVFileType.mp3.rawValue)
            backgroundMusicPlayer?.play()}
        catch let error as NSError {
            print(error.description)
        }
    }
}

//MARK: Draw Line Class

//new class to override drawing function to draw a line for the winning row
class LineView: UIView{
    
    var start = CGPoint(x: 0.0, y: 0.0)
    var end = CGPoint(x: 0.0, y: 0.0)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, start: CGPoint, end: CGPoint){
        super.init(frame: frame)
        self.start = start
        self.end = end
    }
    
    override func draw(_ rect: CGRect) {
        
        let color:UIColor = UIColor.yellow
        
        let winningLine = UIBezierPath()
        winningLine.move(to: start)
        winningLine.addLine(to: end)
        winningLine.close()
        
        color.set()
        winningLine.lineWidth = 10
        winningLine.stroke()
        
    }
    
}





