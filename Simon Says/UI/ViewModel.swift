//
//  ViewModel.swift
//  Simon Says
//
//  Created by Anthony Guay on 4/28/21.
//

import UIKit

class ViewModel: UIViewController {

	var gameManager = GameManager()
	
    override func viewDidLoad() {
        super.viewDidLoad()

    }
	
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
	
	func gameButtonPressed(_ button: UIButton) {
		
	}
	

	
}
