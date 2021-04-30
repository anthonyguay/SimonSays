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
		self.flashOpponentMoves()
		
		if (move == .left){
			//			print ("Left")
		} else if (move == .right){
			//			print ("Right")
		} else if (move == .top){
			//			print ("Top")
		} else if (move == .bottom){
			//			print ("Bottom")
		}
	}
	
	private func flashOpponentMoves() {
		
		for (index, move) in self.viewModel.gameManager.opponent.sequence.moves.enumerated() {
			
			DispatchQueue.main.asyncAfter(deadline: .now() + 1*Double(index+1)) { [self] in
				print ("Move: ", move)
				switch move {
				case .top:
					self.gameButtonTop.backgroundColor = UIColor(red: 124/255, green: 244/255, blue: 90/255, alpha: 1)
				case .left:
					self.gameButtonLeft.backgroundColor = UIColor(red: 242/255, green: 244/255, blue: 90/255, alpha: 1)
				case .right:
					self.gameButtonRight.backgroundColor = UIColor(red: 90/255, green: 144/255, blue: 244/255, alpha: 1)
				case .bottom:
					self.gameButtonBottom.backgroundColor = UIColor(red: 243/255, green: 108/255, blue: 70/255, alpha: 1)
				}
			}
			perform(#selector(styleButtonsBackToOriginal), with: nil, afterDelay: (1*Double(index+1))+1)
		}
	}
	
	@objc private func styleButtonsBackToOriginal(){
		//		DispatchQueue.main.asyncAfter(deadline: .now()) { [self] in
		print("original")
		self.gameButtonTop.backgroundColor = UIColor(red: 124/255, green: 244/255, blue: 90/255, alpha: 0.2)
		self.gameButtonLeft.backgroundColor = UIColor(red: 242/255, green: 244/255, blue: 90/255, alpha: 0.2)
		self.gameButtonRight.backgroundColor = UIColor(red: 90/255, green: 144/255, blue: 244/255, alpha: 0.2)
		self.gameButtonBottom.backgroundColor = UIColor(red: 243/255, green: 108/255, blue: 70/255, alpha: 0.2)
		//		}
	}
}
