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
	
	func isSequenceEqual(local: Sequence, opponent: Sequence) -> Bool {
		
		return false
	}
	func isSequenceComplete(local: Sequence, opponent: Sequence) -> Bool {
		// Called after we check the validity of the moves in the sequence. If both sequences are same length, we know moves are valid so local player is done
		return (local.moves.count == opponent.moves.count)
	}
	
	mutating func addMoveToSequence(_ move: Move){
		self.moves.append(move)
	}
	
}
