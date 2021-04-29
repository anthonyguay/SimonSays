//
//  Sequence.swift
//  Simon Says
//
//  Created by Anthony Guay on 4/28/21.
//

// This object represents a Sequence of Moves 

import Foundation

struct Sequence {
	var moves : [Move] = []
	
	
	// If the latest move matches the corresponding opponent move, we return true and keep the game going
	func isLatestMoveValid(local: Sequence, opponent: Sequence) -> Bool {
		let arraySize = local.moves.count
		var counter = 0
		
		print ("Local moves: ", local.moves)
		print ("Opponent moves: ", opponent.moves)
		while counter < arraySize {
			if (local.moves[counter] != opponent.moves[counter]) {
				return false
			}
			counter+=1
		}
		return true
	}
	
	// Called after we check the validity of the moves in the sequence. If both sequences are same length, we know moves are valid so local player is done
	func isSequenceComplete(local: Sequence, opponent: Sequence) -> Bool {
		return (local.moves.count == opponent.moves.count)
	}
	
	mutating func addMoveToSequence(_ move: Move){
		self.moves.append(move)
	}
	
}
