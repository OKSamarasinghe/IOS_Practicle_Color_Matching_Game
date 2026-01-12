import SwiftUI

enum Difficulty {
    case easy, medium, hard
}

struct GameModel {

    static let allColors: [Color] = [
        .red, .green, .blue, .yellow,
        .orange, .purple, .pink, .cyan
    ]

    static func gridSize(for difficulty: Difficulty) -> Int {
        switch difficulty {
        case .easy:
            return 8
        case .medium:
            return 12
        case .hard:
            return 16
        }
    }

    static func randomColors(count: Int) -> [Color] {
        Array(allColors.shuffled().prefix(count))
    }
}

