import SwiftUI

struct ContentView: View {
    @StateObject private var profileStore = ProfileStore()
    @StateObject private var progressStore = ProgressStore()
    @StateObject private var highScoreStore = HighScoreStore()
    @StateObject private var achievementStore = AchievementStore()

    var body: some View {
        HomeView()
            .environmentObject(profileStore)
            .environmentObject(progressStore)
            .environmentObject(highScoreStore)
            .environmentObject(achievementStore)
    }
}

#Preview {
    ContentView()
}
