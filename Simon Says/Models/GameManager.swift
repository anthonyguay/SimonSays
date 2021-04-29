//
//  GameManager.swift
//  Simon Says
//
//  Created by Anthony Guay on 4/28/21.
//

import Foundation

struct GameManager {
	
	var gameReadyForLocalPlayer = false
	var opponent = Player(type: .computer)
	var localPlayer = Player(type: .local)
	
	// MARK: Public Functions

	
	// MAIN FUNCTION called when the Player touches a button
	func handleMoveAndKeepGameGoing(){

		if (verifyIfMoveIsValid()) {
			if (self.verifyIfSequenceIsFinished()){
				// User has completed the right sequence of moves. Display a status and keep the game going
				self.displayCongrats()
				self.localPlayer.increaseCurrentScore()
				self.generateNewOpponentMove()
				self.displayOpponentSequence()
			} else {
				// User has pressed all the right buttons so far, but is not finished typing the sequence
			}
		} else {
			// Any wrong move terminated the game
			self.displayGameOver()
		}
	}
	
	func restartGame() {
		
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
	
	
	// MARK: UI Delegation
	
	private func displayOpponentSequence() {
		
	}
	
	private func displayCongrats() {
		
	}
	
	private func displayGameOver() {
		
	}
	
	
	
	
	
}
