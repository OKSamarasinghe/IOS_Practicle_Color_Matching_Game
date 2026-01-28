import SwiftUI

struct LevelSelectView: View {
    @EnvironmentObject private var progressStore: ProgressStore

    var body: some View {
        List {
            ForEach(Difficulty.allCases) { diff in
                Section("\(diff.emoji) \(diff.title)") {
                    let unlocked = progressStore.data.unlocked[diff.rawValue] ?? 1

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(1...diff.maxLevels, id: \.self) { levelID in
                                let isUnlocked = levelID <= unlocked
                                NavigationLink {
                                    GameView(level: Level.build(difficulty: diff, id: levelID))
                                } label: {
                                    VStack(spacing: 6) {
                                        Text("Level \(levelID)")
                                            .fontWeight(.bold)
                                        Text(isUnlocked ? "Unlocked" : "Locked")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    .frame(width: 110, height: 70)
                                    .background(isUnlocked ? .black.opacity(0.85) : .gray.opacity(0.25))
                                    .foregroundColor(isUnlocked ? .white : .secondary)
                                    .cornerRadius(16)
                                }
                                .disabled(!isUnlocked)
                            }
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
        }
        .navigationTitle("Levels")
    }
}
