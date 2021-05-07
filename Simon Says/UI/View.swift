//
//  View.swift
//  Simon Says
//
//  Created by Anthony Guay on 4/28/21.
//

import UIKit

class View: UIViewController, GameEventsDelegate {
	
	// UI outlets
	@IBOutlet weak var highScoreLabel: UILabel!
	@IBOutlet weak var currentScoreLabel: UILabel!
	@IBOutlet weak var gameButtonTop: UIButton!
	@IBOutlet weak var gameButtonLeft: UIButton!
	@IBOutlet weak var gameButtonRight: UIButton!
	@IBOutlet weak var gameButtonBottom: UIButton!
	@IBOutlet weak var startGameButton: UIButton!
	@IBOutlet weak var restartGameButton: UIButton!
	
	var viewModel = ViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Set button IDs
		self.gameButtonTop.tag = K.UI.gameButtonTop
		self.gameButtonLeft.tag = K.UI.gameButtonLeft
		self.gameButtonRight.tag = K.UI.gameButtonRight
		self.gameButtonBottom.tag = K.UI.gameButtonBottom
		
		// Style buttons shape
		self.gameButtonTop.layer.cornerRadius = K.UI.buttonsCornerRadius
		self.gameButtonLeft.layer.cornerRadius = K.UI.buttonsCornerRadius
		self.gameButtonRight.layer.cornerRadius = K.UI.buttonsCornerRadius
		self.gameButtonBottom.layer.cornerRadius = K.UI.buttonsCornerRadius
		
		// Style buttons color
		self.styleButtonsBackToOriginal(Timer())
		
		// Only show "Start" button before game starts
		self.startGameButton.isHidden = false
		self.restartGameButton.isHidden = true

		// Set GameEventsDelegate to receive events from GameManager
		self.viewModel.gameManager.gameEventsDelegate = self
		
		// Update High Score label
		self.viewModel.gameManager.loadHighScore()
	}
	
	// MARK: User Interactions
	@IBAction func startGamePressed(_ sender: Any) {
		self.startGameButton.isHidden = true
		self.restartGameButton.isHidden = false
		self.viewModel.gameManager.restartGame()
	}
	
	@IBAction func restartPressed(_ sender: Any) {
		self.present(self.viewModel.restartButtonPressed(), animated: true, completion: nil)
	}
	
	@IBAction func gameButtonPressed(_ sender: UIButton) {
		self.viewModel.gameButtonPressed(sender)
	}
	
	
	// MARK: GameEventsDelegate functions
	func gameOver() {
		self.present(self.viewModel.gameOver(), animated: true, completion: nil)
	}
	
	func updateScores() {
		self.highScoreLabel.text = self.viewModel.getHighScoreLabelText()
		self.currentScoreLabel.text = self.viewModel.getCurrentScoreLabelText()
	}
	
	func newOpponentSequence() {
		// Will loop through every Moves and start a timer to lighten up the button and turn it off after .5 second
		for (index, move) in self.viewModel.gameManager.opponent.sequence.moves.enumerated() {
			
			let timerToColor = Timer(timeInterval: K.UI.durationOfButtonBeingColored*Double(index+1), target: self, selector: #selector(styleButtonsToColor), userInfo: move, repeats: false)

			RunLoop.current.add(timerToColor, forMode: .common)
			
			let timerToNormal = Timer(timeInterval: (K.UI.durationOfButtonBeingColored*Double(index+1))+K.UI.durationBeforeButtonRestoresToOriginal, target: self, selector: #selector(styleButtonsBackToOriginal), userInfo: nil, repeats: false)
			RunLoop.current.add(timerToNormal, forMode: .common)
		}
	}
	
	// MARK: UI

	@objc private func styleButtonsToColor(_ timer: Timer){
		let move = timer.userInfo as? Move

		DispatchQueue.main.async {
			switch move {
			case .top:
				self.gameButtonTop.backgroundColor = K.UI.ButtonsColor.topSelected
			case .left:
				self.gameButtonLeft.backgroundColor = K.UI.ButtonsColor.leftSelected
			case .right:
				self.gameButtonRight.backgroundColor = K.UI.ButtonsColor.rightSelected
			case .bottom:
				self.gameButtonBottom.backgroundColor = K.UI.ButtonsColor.bottomSelected
			default:
				print("")
			}
		}
		timer.invalidate()
	}
	
	@objc private func styleButtonsBackToOriginal(_ timer: Timer){
		timer.invalidate()

		DispatchQueue.main.async {
			self.gameButtonTop.backgroundColor = K.UI.ButtonsColor.topNormal
			self.gameButtonLeft.backgroundColor = K.UI.ButtonsColor.leftNormal
			self.gameButtonRight.backgroundColor = K.UI.ButtonsColor.rightNormal
			self.gameButtonBottom.backgroundColor = K.UI.ButtonsColor.bottomNormal
		}
	}
}
