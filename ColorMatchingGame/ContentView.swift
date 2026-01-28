import SwiftUI

struct ContentView: View {
    @StateObject private var profileStore = ProfileStore()
    @StateObject private var progressStore = ProgressStore()
    @StateObject private var highScoreStore = HighScoreStore()

    var body: some View {
        HomeView()
            .environmentObject(profileStore)
            .environmentObject(progressStore)
            .environmentObject(highScoreStore)
    }
}

#Preview {
    ContentView()
}
