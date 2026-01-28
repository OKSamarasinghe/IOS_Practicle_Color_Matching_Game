import SwiftUI
import Combine


final class GameViewModel: ObservableObject {
    let level: Level

    @Published var score: Int = 0
    @Published var timeRemaining: Int = 0
    @Published var target: ColorToken = .red
    @Published var tiles: [ColorToken] = []
    @Published var matchesDone: Int = 0
    @Published var isGameOver: Bool = false
    @Published var didWin: Bool = false

    // Power-ups
    @Published var hintsLeft: Int = 2
    @Published var freezesLeft: Int = 1
    @Published var isFrozen: Bool = false

    private var timer: AnyCancellable?

    init(level: Level) {
        self.level = level
    }

    func start() {
        score = 0
        matchesDone = 0
        isGameOver = false
        didWin = false
        hintsLeft = 2
        freezesLeft = 1
        isFrozen = false

        timeRemaining = level.timeLimit
        newBoard()
        startTimer()
    }

    func stop() {
        timer?.cancel()
    }

    func tap(_ token: ColorToken) {
        guard !isGameOver else { return }

        if token == target {
            matchesDone += 1
            score += 10 + (level.difficulty == .hard ? 6 : 3)
            Haptics.success()
        } else {
            score = max(score - 6, 0)
            Haptics.error()
        }

        if matchesDone >= level.targetMatchesNeeded {
            win()
        } else {
            newBoard()
        }
    }

    func useHint() {
        guard hintsLeft > 0, !isGameOver else { return }
        hintsLeft -= 1
        // Hint: boost score if next tap correct (soft incentive)
        score += 5
        Haptics.light()
    }

    func useFreeze() {
        guard freezesLeft > 0, !isGameOver else { return }
        freezesLeft -= 1
        isFrozen = true
        Haptics.light()

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isFrozen = false
        }
    }

    private func newBoard() {
        let pool = Array(ColorToken.allCases.shuffled().prefix(level.paletteSize))
        tiles = (0..<level.boxCount).map { _ in pool.randomElement()! }
        target = tiles.randomElement() ?? pool.first ?? .red
    }

    private func startTimer() {
        timer?.cancel()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                guard !self.isGameOver else { return }
                guard !self.isFrozen else { return }

                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.lose()
                }
            }
    }

    private func win() {
        didWin = true
        isGameOver = true
        stop()
    }

    private func lose() {
        didWin = false
        isGameOver = true
        stop()
    }

    var formattedTime: String {
        String(format: "%02d:%02d", timeRemaining / 60, timeRemaining % 60)
    }
}
