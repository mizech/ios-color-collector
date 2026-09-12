import Foundation
import SwiftUI

@Observable
class MainViewModel {
	private var firstRow = Color.gray
	private var secRow = Color.gray
	private var thirdRow = Color.gray
	private var fourthRow = Color.gray
	private let feasibleColors = [
		Color.blue,
		Color.brown,
		Color.cyan,
		Color.green,
		Color.indigo,
		Color.mint,
		Color.orange,
		Color.pink,
		Color.red,
		Color.teal,
		Color.yellow
	]
	private(set) var colors = [Color]()
	private(set) var suggestedColor = Color.blue
	private(set) var usedColors = [Color]()
	private(set) var currentSeconds = 0
	private(set) var isGameRunning = false
	
	func updateColors(with color: Color, at index: Int) {
		// Guard against invalid indices to prevent out-of-bounds access
		guard colors.indices.contains(index) else {
			print("Index out of range: \(index)")
			return
		}
		
		if (
			index < 4 && firstRow == Color.gray && usedColors
				.contains(color) == false
		) {
			firstRow = color
			usedColors.append(color)
		} else if (
			index >= 4 && index < 8 && secRow == Color.gray && usedColors
				.contains(color) == false) {
			secRow = color
			usedColors.append(color)
		} else if (
			index >= 8 && index < 12 && thirdRow == Color.gray && usedColors
				.contains(color) == false) {
			thirdRow = color
			usedColors.append(color)
		} else if (
			index >= 12 && index < 16 && fourthRow == Color.gray && usedColors
				.contains(color) == false) {
			fourthRow = color
			usedColors.append(color)
		}
		
		if (index < 4 && firstRow != Color.gray &&
			colors[index] == Color.gray && color == firstRow) {
			colors[index] = color
		} else if (index >= 4 && index < 8 && secRow != Color.gray &&
		   colors[index] == Color.gray && color == secRow) {
			colors[index] = color
		} else if (index >= 8 && index < 12 && thirdRow != Color.gray
			&& colors[index] == Color.gray && color == thirdRow
		) {
			colors[index] = color
		} else if (
			index >= 12 && fourthRow != Color.gray && colors[index] == Color.gray
			&& color == fourthRow) {
			colors[index] = color
		}
	}
	
	func incrementCurrentSeconds() {
		currentSeconds += 1
	}
	
	func isGameOver() -> Bool {
		return colors.allSatisfy { color in
			color != Color.gray
		}
	}
	
	func randomSuggestedColor() {
		if let color = feasibleColors.randomElement() {
			suggestedColor = color
		}
	}
	
	func startNewGame() {
		setInitialState()
		isGameRunning = true
	}
	
	func toggleIsGameRunning() {
		isGameRunning.toggle()
	}
	
	func setInitialState() {
		firstRow = Color.gray
		secRow = Color.gray
		thirdRow = Color.gray
		fourthRow = Color.gray
		usedColors.removeAll()
		
		colors.removeAll()
		for i in 0..<16 {
			colors.append(Color.gray)
		}
		
		randomSuggestedColor()
		isGameRunning = false
		currentSeconds = 0
	}
}

