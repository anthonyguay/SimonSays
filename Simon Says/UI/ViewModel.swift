//
//  ViewModel.swift
//  Simon Says
//
//  Created by Anthony Guay on 4/28/21.
//

import UIKit

class ViewModel: UIViewController {

	var gameManager = GameManager()
	
	// MARK: User interaction
	func gameButtonPressed(_ button: UIButton) {
		switch button.tag {
		case K.UI.gameButtonTop:
			self.gameManager.handleLocalMove(.top)
		case K.UI.gameButtonLeft:
			self.gameManager.handleLocalMove(.left)
		case K.UI.gameButtonRight:
			self.gameManager.handleLocalMove(.right)
		case K.UI.gameButtonBottom:
			self.gameManager.handleLocalMove(.bottom)
		default:
			print()
		}
	}

	// MARK: UI Functions
	func getHighScoreLabelText() -> String {
		return "High Score: " + String(self.gameManager.localPlayer.highScore)
	}
	func getCurrentScoreLabelText() -> String {
		return "Current Score: " + String(self.gameManager.localPlayer.currentScore)
	}
	
	// MARK: Alert Windows
	func restartButtonPressed() -> UIAlertController {
		let alertWindow = UIAlertController(title: "Warning", message: "Are you sure you want to restart the game?", preferredStyle: .alert)
		let yesButton = UIAlertAction(title: "Yes", style: .destructive, handler: { (action) -> Void in
			self.gameManager.restartGame()
		})
		let cancelButton = UIAlertAction(title: "Cancel", style: .default) { (action) -> Void in}
		alertWindow.addAction(cancelButton)
		alertWindow.addAction(yesButton)
		
		return alertWindow
	}
	
	func gameOver() -> UIAlertController {
		let alertWindow = UIAlertController(title: "Game over", message: "You tried your best! Play again?", preferredStyle: .alert)
		let yesButton = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
			self.gameManager.restartGame()
		})
		let noButton = UIAlertAction(title: "No", style: .default) { (action) -> Void in}
		alertWindow.addAction(noButton)
		alertWindow.addAction(yesButton)
		
		return alertWindow
	}
	
}
