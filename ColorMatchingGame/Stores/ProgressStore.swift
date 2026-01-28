import Foundation
import Foundation
import Combine


struct ProgressData: Codable {
    // Store as String keys to encode safely
    var unlocked: [String: Int] = [
        Difficulty.easy.rawValue: 1,
        Difficulty.medium.rawValue: 1,
        Difficulty.hard.rawValue: 1
    ]
}

final class ProgressStore: ObservableObject {
    private let key = "progressData"
    @Published var data: ProgressData {
        didSet { save() }
    }

    init() {
        self.data = UserDefaults.standard.codableValue(
            ProgressData.self,
            forKey: key,
            default: ProgressData()
        )
    }

    func isUnlocked(difficulty: Difficulty, level: Int) -> Bool {
        (data.unlocked[difficulty.rawValue] ?? 1) >= level
    }

    func unlockedLevel(for difficulty: Difficulty) -> Int {
        data.unlocked[difficulty.rawValue] ?? 1
    }

    func unlockNext(difficulty: Difficulty, currentLevel: Int) {
        let next = min(currentLevel + 1, difficulty.maxLevels)
        let existing = data.unlocked[difficulty.rawValue] ?? 1
        if next > existing {
            data.unlocked[difficulty.rawValue] = next
        }
    }

    private func save() {
        UserDefaults.standard.setCodable(data, forKey: key)
    }
}
