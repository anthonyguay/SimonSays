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
				self.generateNewOpponentMove()
				self.displayOpponentSequence()
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
//		localPlayer.highScore = SaveToDisk().retrieveHighScoreFromDisk()
		self.gameEventsDelegate?.updateScores()
	}
	
	
	// MARK: Private Functions - game mechanics

	private func verifyIfMoveIsValid() -> Bool {
//		self.localPlayer.sequence.isSequenceEqual(local: <#T##Sequence#>, opponent: <#T##Sequence#>)
		return true
	}
	
	private func verifyIfSequenceIsFinished() -> Bool {
		return true
	}
	
	private func generateNewOpponentMove() {
		
	}
	private func displayOpponentSequence() {
		
	}
	
	private func saveScore(){
		if (localPlayer.currentScore > localPlayer.highScore){
			SaveToDisk().persistHighScoreToDisk(score: localPlayer.currentScore)
		}
	}
	
	
	
	
	
	
	
	
}
