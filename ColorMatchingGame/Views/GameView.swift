import SwiftUI

struct GameView: View {
    @EnvironmentObject private var profileStore: ProfileStore
    @EnvironmentObject private var progressStore: ProgressStore
    @EnvironmentObject private var highScoreStore: HighScoreStore
    @EnvironmentObject private var achievementStore: AchievementStore

    @Environment(\.dismiss) private var dismiss

    let level: Level
    @StateObject private var vm: GameViewModel

    @State private var goToNextLevel: Bool = false
    @State private var goBackToLevels: Bool = false

    init(level: Level) {
        self.level = level
        _vm = StateObject(wrappedValue: GameViewModel(level: level))
    }

    var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 10), count: level.gridColumns)
    }

    var body: some View {
        VStack(spacing: 14) {

            // Top bar
            HStack {
                Text("⏱ \(vm.formattedTime)")
                    .fontWeight(.bold)
                    .foregroundColor(vm.timeRemaining <= 10 ? .red : .primary)

                Spacer()

                Text("⭐ \(vm.score)")
                    .fontWeight(.bold)
            }
            .padding(.horizontal)

            VStack(spacing: 6) {
                Text("\(level.difficulty.emoji) \(level.difficulty.title) • Level \(level.id)")
                    .font(.headline)
                    .foregroundColor(.secondary)

                Text("Match: \(vm.target.name)")
                    .font(.title3)
                    .fontWeight(.bold)
            }

            RoundedRectangle(cornerRadius: 18)
                .fill(vm.target.color)
                .frame(width: 120, height: 120)
                .shadow(radius: 8)
                .overlay(
                    Text("\(vm.matchesDone)/\(level.targetMatchesNeeded)")
                        .font(.caption)
                        .fontWeight(.bold)
                        .padding(8)
                        .background(.black.opacity(0.35))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(8),
                    alignment: .bottomTrailing
                )

            // Power-ups
            HStack(spacing: 12) {
                Button {
                    vm.useHint()
                } label: {
                    powerUp(title: "Hint", icon: "lightbulb.fill", count: vm.hintsLeft)
                }
                .disabled(vm.hintsLeft == 0 || vm.isGameOver)

                Button {
                    vm.useFreeze()
                } label: {
                    powerUp(title: "Freeze", icon: "snowflake", count: vm.freezesLeft)
                }
                .disabled(vm.freezesLeft == 0 || vm.isGameOver)
            }
            .padding(.horizontal)

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(vm.tiles.indices, id: \.self) { i in
                    RoundedRectangle(cornerRadius: 12)
                        .fill(vm.tiles[i].color)
                        .frame(height: 54)
                        .shadow(radius: 3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(vm.isFrozen ? .white.opacity(0.6) : .clear, lineWidth: 2)
                        )
                        .onTapGesture {
                            vm.tap(vm.tiles[i])
                        }
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding(.top)
        .navigationTitle("Play")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { vm.start() }
        .onDisappear { vm.stop() }

        // Continue -> Next level navigation
        .navigationDestination(isPresented: $goToNextLevel) {
            let nextLevelID = min(level.id + 1, level.difficulty.maxLevels)
            GameView(level: Level.build(difficulty: level.difficulty, id: nextLevelID))
                .environmentObject(profileStore)
                .environmentObject(progressStore)
                .environmentObject(highScoreStore)
                .environmentObject(achievementStore)
        }

        // Close -> Levels
        .onChange(of: goBackToLevels) { _, newValue in
            if newValue {
                dismiss()
            }
        }

        // Game Over sheet
        .sheet(isPresented: $vm.isGameOver) {
            GameOverView(
                didWin: vm.didWin,
                score: vm.score,
                difficulty: level.difficulty,
                levelID: level.id,
                onContinue: {
                    saveScoreAndAchievements()

                    if vm.didWin {
                        progressStore.unlockNext(difficulty: level.difficulty, currentLevel: level.id)

                        if level.id < level.difficulty.maxLevels {
                            goToNextLevel = true
                        } else {
                            goBackToLevels = true
                        }
                    } else {
                        goBackToLevels = true
                    }
                },
                onCloseToLevels: {
                    saveScoreAndAchievements()
                    goBackToLevels = true
                }
            )
        }
    }

    private func saveScoreAndAchievements() {
        // Always save score locally
        let entry = HighScoreEntry(
            playerName: profileStore.profile.name,
            difficulty: level.difficulty,
            level: level.id,
            score: vm.score
        )
        highScoreStore.add(entry)

        // Local achievements
        if vm.didWin {
            achievementStore.unlock(.firstWin)

            if vm.score >= 100 {
                achievementStore.unlock(.scoreHundred)
            }
        }
    }

    private func powerUp(title: String, icon: String, count: Int) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
            Text("\(title) x\(count)")
                .fontWeight(.bold)
        }
        .foregroundColor(.white)
        .padding(.vertical, 10)
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity)
        .background(.black.opacity(0.85))
        .cornerRadius(14)
        .shadow(radius: 4)
    }
}
