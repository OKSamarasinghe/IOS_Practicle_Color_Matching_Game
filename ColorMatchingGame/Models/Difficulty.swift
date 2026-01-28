import Foundation

enum Difficulty: String, CaseIterable, Identifiable, Codable {
    case easy, medium, hard
    var id: String { rawValue }

    var title: String {
        switch self {
        case .easy: return "Easy"
        case .medium: return "Medium"
        case .hard: return "Hard"
        }
    }

    var emoji: String {
        switch self {
        case .easy: return "🍀"
        case .medium: return "🔥"
        case .hard: return "⚡️"
        }
    }

    var maxLevels: Int {
        switch self {
        case .easy: return 10
        case .medium: return 15
        case .hard: return 20
        }
    }
}
