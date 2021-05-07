//
//  Constants.swift
//


import Foundation
import UIKit

struct K {
	
	struct UI {
		
		// Time waited before displaying alert windows
		static let delayBeforeShowingAlertViews = 0.5
		
		// Time waited before animating the buttons color change
		static let durationOfButtonBeingColored = 1.0
		static let durationBeforeButtonRestoresToOriginal = 0.5

		// Game Buttons Style
		static let buttonsCornerRadius: CGFloat = 10
		
		// Game Buttons IDs
		static let gameButtonTop = 0
		static let gameButtonLeft = 1
		static let gameButtonRight = 2
		static let gameButtonBottom = 3
		
		struct ButtonsColor {
			static let topSelected = UIColor(red: 124/255, green: 244/255, blue: 90/255, alpha: 1)
			static let topNormal = UIColor(red: 124/255, green: 244/255, blue: 90/255, alpha: 0.35)
			
			static let leftSelected = UIColor(red: 242/255, green: 244/255, blue: 90/255, alpha: 1)
			static let leftNormal = UIColor(red: 242/255, green: 244/255, blue: 90/255, alpha: 0.35)
			
			static let rightSelected = UIColor(red: 90/255, green: 144/255, blue: 244/255, alpha: 1)
			static let rightNormal = UIColor(red: 90/255, green: 144/255, blue: 244/255, alpha: 0.35)
			
			static let bottomSelected = UIColor(red: 243/255, green: 108/255, blue: 70/255, alpha: 1)
			static let bottomNormal = UIColor(red: 243/255, green: 108/255, blue: 70/255, alpha: 0.35)
		}
		
	}
	
	
	

	
}

