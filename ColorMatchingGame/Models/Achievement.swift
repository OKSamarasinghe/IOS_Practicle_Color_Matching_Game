import Foundation

enum AchievementID: String, Codable, CaseIterable {
    case firstWin
    case winThreeLevels
    case noMistakes
    case scoreHundred
}

struct Achievement: Identifiable, Codable {
    let id: AchievementID
    let title: String
    let description: String
    let badge: Badge
}
