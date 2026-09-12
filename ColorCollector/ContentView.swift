import Combine
import SwiftUI

struct ContentView: View {
	@Environment(MainViewModel.self) private var mainVM
	@State private var isConfirmShown = false
	@State private var isGameOverShown = false
	
	let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
	
	let columns = [GridItem(.flexible(minimum: 60, maximum: 120)),
				   GridItem(.flexible(minimum: 60, maximum: 120)),
				   GridItem(.flexible(minimum: 60, maximum: 120)),
				   GridItem(.flexible(minimum: 60, maximum: 120))]
	var body: some View {
		NavigationStack {
			VStack() {
				Text("\(mainVM.currentSeconds)")
					.font(.system(size: 64))
					.fontWeight(.bold)
				LazyVGrid(columns: columns, spacing: 8) {
					ForEach(0..<16, id: \.self) { i in
						RoundedRectangle(cornerRadius: 16)
							.fill(mainVM.colors[i])
							.frame(width: 80, height: 80)
							.dropDestination(for: Color.self) { colors, _ in
								if let color = colors.first {
									mainVM.updateColors(with: color, at: i)
									mainVM.randomSuggestedColor()
									isGameOverShown = mainVM.isGameOver()
								}
							}
					}
				}
				HStack {
					Spacer()
					RoundedRectangle(cornerRadius: 16)
						.fill(mainVM.suggestedColor)
						.frame(width: 80, height: 80)
						.draggable(mainVM.suggestedColor) {
							RoundedRectangle(cornerRadius: 16)
								.fill(mainVM.suggestedColor)
								.frame(width: 80, height: 80)
								.opacity(0.6)
						}
						.onTapGesture {
							mainVM.randomSuggestedColor()
						}
					Spacer()
				}
				.padding(.top, 10)
			}.toolbar {
				ToolbarItem(placement: .topBarTrailing) {
					Button {
						isConfirmShown = true
					} label: {
						Image(systemName: "arrow.clockwise.circle")
					}.confirmationDialog("Restart Game",
										 isPresented: $isConfirmShown) {
						Button("Cancel") {
							isConfirmShown = false
						}
						Button {
							mainVM.setInitialState()
						} label: {
							Text("Restart")
						}
					} message: {
						Text("Restart Game: Are you sure?")
					}
				}
			}
			.alert("Game over!", isPresented: $isGameOverShown) {
				Button("Okay") {
					mainVM.setInitialState()
				}
			} message: {
				Text("Finished!")
			}
			.onReceive(timer) { _ in
				mainVM.incrementCurrentSeconds()
			}
		}
	}
}

#Preview {
	ContentView()
}
