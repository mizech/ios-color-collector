import SwiftUI

@main
struct ColorCollectorApp: App {
	let mainVM = MainViewModel()
	
    var body: some Scene {
        WindowGroup {
			ContentView().environment(mainVM)
        }
    }
}
