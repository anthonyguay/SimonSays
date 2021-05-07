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
	func newOpponentSequence()
}

struct GameManager {
		
	var gameEventsDelegate: GameEventsDelegate?
	var opponent = Player(type: .computer)
	var localPlayer = Player(type: .local)
	
	// MARK: Public Functions
	
	mutating func handleLocalMove(_ move: Move){
		localPlayer.sequence.addMoveToSequence(move)
		
		if (verifyIfMoveIsValid()) {
			// Last move is valid
			if (self.verifyIfSequenceIsFinished()){
				// User has completed the entire sequence of moves. Keep the game going
				self.localPlayer.increaseCurrentScore()
				self.gameEventsDelegate?.updateScores()
				self.generateNewOpponentMove()
				self.localPlayer.sequence = Sequence()
			} else {
				// User has pressed all the right buttons so far, but is not finished typing the sequence
			}
		} else {
			// Any wrong move terminates the game
			self.saveScore()
			self.gameEventsDelegate?.gameOver()
		}
	}
	
	mutating func loadHighScore(){
		localPlayer = Player(type: .local)
		localPlayer.highScore = DiskManager().retrieveHighScoreFromDisk()
		self.gameEventsDelegate?.updateScores()
	}
	
	mutating func restartGame() {
		self.saveScore()
		opponent = Player(type: .computer)
		localPlayer = Player(type: .local)
		localPlayer.highScore = DiskManager().retrieveHighScoreFromDisk()
		self.gameEventsDelegate?.updateScores()
		self.generateNewOpponentMove()
	}
	
	
	// MARK: Private Functions - Game Logic
	
	private mutating func verifyIfMoveIsValid() -> Bool {
		return self.localPlayer.sequence.isLatestMoveValid(local: localPlayer.sequence, opponent: opponent.sequence)
	}
	
	private func verifyIfSequenceIsFinished() -> Bool {
		return self.localPlayer.sequence.isSequenceComplete(local: localPlayer.sequence, opponent: opponent.sequence)
	}
	
	// Generates a random move, adds it to the oppponent's existing sequence, and tells the view to display the sequence
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
		self.gameEventsDelegate?.newOpponentSequence()
	}
	
	private func saveScore(){
		if (localPlayer.currentScore > localPlayer.highScore){
			DiskManager().persistHighScoreToDisk(score: localPlayer.currentScore)
		}
	}	
	
}
