import SwiftUI

struct AchievementsView: View {
    @EnvironmentObject private var achievementStore: AchievementStore

    var body: some View {
        List {
            achievementRow(.firstWin, "First Win", "Clear your first level")
            achievementRow(.winThreeLevels, "Champion", "Win 3 levels")
            achievementRow(.noMistakes, "Perfect", "No mistakes in a level")
            achievementRow(.scoreHundred, "Scorer", "Score 100+")
        }
        .navigationTitle("Achievements")
    }

    private func achievementRow(
        _ id: AchievementID,
        _ title: String,
        _ desc: String
    ) -> some View {
        HStack {
            Text(achievementStore.isUnlocked(id) ? "🏆" : "🔒")
            VStack(alignment: .leading) {
                Text(title).fontWeight(.bold)
                Text(desc).font(.caption)
            }
        }
    }
}
