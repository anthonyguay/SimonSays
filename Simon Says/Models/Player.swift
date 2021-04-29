//
//  Player.swift
//  Simon Says
//
//  Created by Anthony Guay on 4/28/21.
//

import Foundation

enum PlayerType {
	case local
	case computer
}

struct Player {
	var highScore: Int
	var sequence: Sequence
	var type: PlayerType

	init(type: PlayerType) {
		self.sequence = Sequence()
		self.type = type
		self.highScore = 0
		
		if (type == .local) {
			let highScore = SaveToDisk().retrieveHighScoreFromDisk()
			print ("High score retrieved: ", highScore)
		}
	}

	func increaseCurrentScore(){
		self.highScore+=1
	}
	
}


