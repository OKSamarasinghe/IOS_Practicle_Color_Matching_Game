import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var highScoreStore: HighScoreStore
    @EnvironmentObject private var progressStore: ProgressStore

    var body: some View {
        Form {
            Section("Game Data") {
                Button(role: .destructive) {
                    highScoreStore.entries.removeAll()
                    Haptics.light()
                } label: {
                    Text("Reset Leaderboard")
                }

                Button(role: .destructive) {
                    progressStore.data = ProgressData()
                    Haptics.light()
                } label: {
                    Text("Reset Level Progress")
                }
            }

            Section("About") {
                Text("Color Matching Game")
                Text("Made with SwiftUI 🎨")
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("Settings")
    }
}
