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
	mutating func handleLocalMove(_ move: Move){

		localPlayer.sequence.addMoveToSequence(move)
		print("Adding move to sequence")
		
		if (verifyIfMoveIsValid()) {
			// Last move is valid
			if (self.verifyIfSequenceIsFinished()){
				// User has completed the entire sequence of moves. Display a status and keep the game going
				print("Sequence completed")
				self.localPlayer.increaseCurrentScore()
				self.gameEventsDelegate?.updateScores()
				self.generateNewOpponentMove()
				self.localPlayer.sequence = Sequence()
			} else {
				print("In progress...")
				// User has pressed all the right buttons so far, but is not finished typing the sequence
			}
		} else {
			// Any wrong move terminates the game
			print ("Not valid")
			self.saveScore()
			self.gameEventsDelegate?.gameOver()
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
		self.gameEventsDelegate?.newOpponentMove(move!)
	}
	
	private func saveScore(){
		if (localPlayer.currentScore > localPlayer.highScore){
			DiskManager().persistHighScoreToDisk(score: localPlayer.currentScore)
		}
	}
	
	
	
	
	
	
	
	
}
