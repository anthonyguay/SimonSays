//
//  SaveToDisk.swift
//  Simon Says
//
//  Created by Anthony Guay on 4/28/21.
//

import Foundation

struct SaveToDisk {
	let defaults = UserDefaults.standard
	
	func persistHighScoreToDisk(score: Int) {
		print("Persist score")
		defaults.set(score, forKey: "highscore")
	}
	
	func retrieveHighScoreFromDisk() -> Int {
		print("retrieve score")
		return defaults.integer(forKey: "highscore")
	}
}
