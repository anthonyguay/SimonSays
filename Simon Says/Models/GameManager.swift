//
//  GameManager.swift
//  Simon Says
//
//  Created by Anthony Guay on 4/28/21.
//

import Foundation

// MARK: Protocol declaration to let UI handle game events
protocol GameEventsDelegate: NSObject {
	func gameOver()
	func updateScores()
	func newOpponentMove(_ move: Move)
}

struct GameManager {
		
	var gameEventsDelegate: GameEventsDelegate?
	var opponent = Player(type: .computer)
	var localPlayer = Player(type: .local)
	
	// MARK: Public Functions
	
	// MAIN FUNCTION called when the Player touches a button
	mutating func handleLocalMove(_move: Move){

		if (verifyIfMoveIsValid()) {
			if (self.verifyIfSequenceIsFinished()){
				// User has completed the right sequence of moves. Display a status and keep the game going
				self.localPlayer.increaseCurrentScore()
				self.gameEventsDelegate?.updateScores()
				self.generateNewOpponentMove()

			} else {
				// User has pressed all the right buttons so far, but is not finished typing the sequence
			}
		} else {
			// Any wrong move terminates the game
			self.saveScore()
			self.restartGame()
		}
	}
	
	mutating func restartGame() {
		opponent = Player(type: .computer)
		localPlayer = Player(type: .local)
		localPlayer.highScore = DiskManager().retrieveHighScoreFromDisk()
		self.gameEventsDelegate?.updateScores()
		self.generateNewOpponentMove()
	}
	
	
	// MARK: Private Functions - game mechanics

	private mutating func verifyIfMoveIsValid() -> Bool {
//		self.localPlayer.sequence.isSequenceEqual(local: <#T##Sequence#>, opponent: <#T##Sequence#>)
		
		
		return true
	}
	
	private func verifyIfSequenceIsFinished() -> Bool {
		return true
	}
	
	private mutating func generateNewOpponentMove() {
		let randomInt = Int.random(in: 1..<5)
		var move: Move?
		
		if (randomInt == 1){
			move = .top
		} else if (randomInt == 2){
			move = .left
		} else if (randomInt == 3){
			move = .right
		} else if (randomInt == 4){
			move = .bottom
		}
		self.opponent.sequence.addMoveToSequence(move!)
		self.gameEventsDelegate?.newOpponentMove(move!)
	}
	
	private func saveScore(){
		if (localPlayer.currentScore > localPlayer.highScore){
			DiskManager().persistHighScoreToDisk(score: localPlayer.currentScore)
		}
	}
	
	
	
	
	
	
	
	
}
