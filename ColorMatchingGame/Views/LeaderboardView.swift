import SwiftUI

struct LeaderboardView: View {
    @EnvironmentObject private var highScoreStore: HighScoreStore
    @State private var selectedDifficulty: Difficulty = .easy

    var body: some View {
        VStack(spacing: 10) {
            Picker("Difficulty", selection: $selectedDifficulty) {
                ForEach(Difficulty.allCases) { d in
                    Text("\(d.emoji) \(d.title)").tag(d)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

            List {
                let top = highScoreStore.top(for: selectedDifficulty)
                if top.isEmpty {
                    Text("No scores yet. Go create chaos with colors 🎯")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(Array(top.prefix(20)).enumerated(), id: \.element.id) { index, entry in
                        HStack {
                            Text("#\(index + 1)")
                                .fontWeight(.bold)
                                .frame(width: 45, alignment: .leading)

                            VStack(alignment: .leading) {
                                Text(entry.playerName).fontWeight(.semibold)
                                Text("Level \(entry.level) • \(entry.date.formatted(date: .abbreviated, time: .shortened))")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()
                            Text("\(entry.score)")
                                .fontWeight(.bold)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle("Leaderboard")
    }
}
