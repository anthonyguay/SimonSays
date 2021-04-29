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
	var currentScore: Int
	var sequence: Sequence
	var type: PlayerType

	init(type: PlayerType) {
		self.sequence = Sequence()
		self.type = type
		self.currentScore = 0
		self.highScore = 0
	}

	mutating func increaseCurrentScore(){
		self.currentScore+=1
	}
	
}


