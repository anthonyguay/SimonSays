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
	
	var viewModel = ViewModel()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Set button IDs
		self.gameButtonTop.tag = K.UI.gameButtonTop
		self.gameButtonLeft.tag = K.UI.gameButtonLeft
		self.gameButtonRight.tag = K.UI.gameButtonRight
		self.gameButtonBottom.tag = K.UI.gameButtonBottom
		
		self.gameButtonTop.layer.cornerRadius = 10
		self.gameButtonLeft.layer.cornerRadius = 10
		self.gameButtonRight.layer.cornerRadius = 10
		self.gameButtonBottom.layer.cornerRadius = 10
		self.styleButtonsBackToOriginal(Timer())
		
		// Set GameEventsDelegate to receive events from GameManager
		self.viewModel.gameManager.gameEventsDelegate = self
		self.viewModel.gameManager.restartGame()
	}
	
	// User Interactions
	@IBAction func restartPressed(_ sender: Any) {
		self.present(self.viewModel.restartButtonPressed(), animated: true, completion: nil)
	}
	
	@IBAction func gameButtonPressed(_ sender: UIButton) {
		self.viewModel.gameButtonPressed(sender)
	}
	
	
	// GameEventsDelegate functions
	func gameOver() {
		self.present(self.viewModel.gameOver(), animated: true, completion: nil)
	}
	
	func updateScores() {
		self.highScoreLabel.text = self.viewModel.getHighScoreLabelText()
		self.currentScoreLabel.text = self.viewModel.getCurrentScoreLabelText()
	}
	
	func newOpponentMove(_ move: Move) {
		// Will loop through every Moves and start a timer to lighten up the button and turn it off after .5 second
		for (index, move) in self.viewModel.gameManager.opponent.sequence.moves.enumerated() {
			
			let timerToColor = Timer(timeInterval: 1*Double(index+1), target: self, selector: #selector(styleButtonsToColor), userInfo: move, repeats: false)
			RunLoop.current.add(timerToColor, forMode: .common)
			timerToColor.tolerance = 0.1
			
			let timerToNormal = Timer(timeInterval: (1*Double(index+1))+0.5, target: self, selector: #selector(styleButtonsBackToOriginal), userInfo: nil, repeats: false)
			RunLoop.current.add(timerToNormal, forMode: .common)
			timerToNormal.tolerance = 0.1
		}
	}
	
	@objc private func styleButtonsToColor(_ timer: Timer){
		let move = timer.userInfo as? Move

		DispatchQueue.main.asyncAfter(deadline: .now()) { [self] in
			switch move {
			case .top:
				self.gameButtonTop.backgroundColor = UIColor(red: 124/255, green: 244/255, blue: 90/255, alpha: 1)
			case .left:
				self.gameButtonLeft.backgroundColor = UIColor(red: 242/255, green: 244/255, blue: 90/255, alpha: 1)
			case .right:
				self.gameButtonRight.backgroundColor = UIColor(red: 90/255, green: 144/255, blue: 244/255, alpha: 1)
			case .bottom:
				self.gameButtonBottom.backgroundColor = UIColor(red: 243/255, green: 108/255, blue: 70/255, alpha: 1)
			default:
				print("")
			}
		}
		timer.invalidate()
	}
	
	@objc private func styleButtonsBackToOriginal(_ timer: Timer){
		timer.invalidate()

		DispatchQueue.main.asyncAfter(deadline: .now()) { [self] in
			self.gameButtonTop.backgroundColor = UIColor(red: 124/255, green: 244/255, blue: 90/255, alpha: 0.2)
			self.gameButtonLeft.backgroundColor = UIColor(red: 242/255, green: 244/255, blue: 90/255, alpha: 0.2)
			self.gameButtonRight.backgroundColor = UIColor(red: 90/255, green: 144/255, blue: 244/255, alpha: 0.2)
			self.gameButtonBottom.backgroundColor = UIColor(red: 243/255, green: 108/255, blue: 70/255, alpha: 0.2)
		}
	}
}
