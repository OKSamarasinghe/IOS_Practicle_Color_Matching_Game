import SwiftUI

enum Difficulty {
    case easy, medium, hard
}

struct GameModel {

    static let allColors: [Color] = [
        .red, .green, .blue, .yellow,
        .orange, .purple, .pink, .cyan,
        .mint, .indigo, .teal, .brown,
        .gray
    ]

    // MARK: - Number of boxes
    static func boxCount(for difficulty: Difficulty) -> Int {
        switch difficulty {
        case .easy:
            return 10
        case .medium:
            return 15
        case .hard:
            return 30
        }
    }

    // MARK: - Time limits
    static func timeLimit(for difficulty: Difficulty) -> Int {
        switch difficulty {
        case .easy:
            return 90
        case .medium:
            return 60
        case .hard:
            return 30
        }
    }

    // MARK: - Color logic
    static func generateColors(for difficulty: Difficulty) -> [Color] {
        let count = boxCount(for: difficulty)

        switch difficulty {

        case .easy:
            // Unique colors → easy
            return Array(allColors.shuffled().prefix(count))

        case .medium:
            // Some duplicates → harder
            let pool = Array(allColors.shuffled().prefix(6))
            return (0..<count).map { _ in pool.randomElement()! }

        case .hard:
            // Many duplicates → very hard
            let pool = Array(allColors.shuffled().prefix(4))
            return (0..<count).map { _ in pool.randomElement()! }
        }
    }
}
