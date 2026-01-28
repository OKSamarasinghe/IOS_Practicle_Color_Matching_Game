import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var highScoreStore: HighScoreStore
    @EnvironmentObject private var progressStore: ProgressStore
    @EnvironmentObject private var profileStore: ProfileStore
    @EnvironmentObject private var achievementStore: AchievementStore

    var body: some View {
        Form {
            Section("Tutorial") {
                Button("Replay Tutorial") {
                    profileStore.profile.tutorialCompleted = false
                    Haptics.light()
                }
            }

            Section("Achievements") {
                Button(role: .destructive) {
                    achievementStore.reset()
                    Haptics.light()
                } label: {
                    Text("Reset Achievements")
                }
            }

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
                Text("Local Mode (No Firebase Yet)")
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("Settings")
    }
}
