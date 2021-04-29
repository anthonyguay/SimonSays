//
//  DiskManager.swift
//  Simon Says
//
//  Created by Anthony Guay on 4/28/21.
//

import Foundation

struct DiskManager {
	let defaults = UserDefaults.standard
	
	func persistHighScoreToDisk(score: Int) {
		defaults.set(score, forKey: "highscore")
	}
	
	func retrieveHighScoreFromDisk() -> Int {
		return defaults.integer(forKey: "highscore")
	}
}
