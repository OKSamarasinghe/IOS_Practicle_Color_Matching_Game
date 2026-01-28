import Foundation
import Foundation
import Combine


final class HighScoreStore: ObservableObject {
    private let key = "highScores"
    @Published var entries: [HighScoreEntry] {
        didSet { save() }
    }

    init() {
        self.entries = UserDefaults.standard.codableValue([HighScoreEntry].self, forKey: key, default: [])
    }

    func add(_ entry: HighScoreEntry) {
        entries.append(entry)
        // Keep best 50
        entries = entries
            .sorted { $0.score > $1.score }
            .prefix(50)
            .map { $0 }
    }

    func top(for difficulty: Difficulty) -> [HighScoreEntry] {
        entries.filter { $0.difficulty == difficulty }.sorted { $0.score > $1.score }
    }

    private func save() {
        UserDefaults.standard.setCodable(entries, forKey: key)
    }
}
