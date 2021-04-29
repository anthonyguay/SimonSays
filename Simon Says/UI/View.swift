//
//  View.swift
//  Simon Says
//
//  Created by Anthony Guay on 4/28/21.
//

import UIKit

class View: UIViewController {

	// UI outlets
	@IBOutlet weak var highScoreLabel: UILabel!
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
	}
	
	
	@IBAction func restartPressed(_ sender: Any) {
		self.present(self.viewModel.restartButtonPressed(), animated: true, completion: nil)
	}
	
	@IBAction func gameButtonPressed(_ sender: UIButton) {
		self.viewModel.gameButtonPressed(sender)
	}
}
