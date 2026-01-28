import Foundation

struct HighScoreEntry: Identifiable, Codable, Hashable {
    let id: UUID
    let playerName: String
    let difficulty: Difficulty
    let level: Int
    let score: Int
    let date: Date

    init(playerName: String, difficulty: Difficulty, level: Int, score: Int) {
        self.id = UUID()
        self.playerName = playerName
        self.difficulty = difficulty
        self.level = level
        self.score = score
        self.date = Date()
    }
}
