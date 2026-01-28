import Foundation
import Combine

final class AchievementStore: ObservableObject {
    private let key = "achievements"

    @Published private(set) var unlocked: Set<AchievementID> = [] {
        didSet {
            UserDefaults.standard.setCodable(Array(unlocked), forKey: key)
        }
    }

    init() {
        let saved = UserDefaults.standard.codableValue([AchievementID].self, forKey: key, default: [])
        self.unlocked = Set(saved)
    }

    func unlock(_ id: AchievementID) {
        guard !unlocked.contains(id) else { return }
        unlocked.insert(id)
        // saving happens automatically in didSet
    }

    func isUnlocked(_ id: AchievementID) -> Bool {
        unlocked.contains(id)
    }

    // ✅ NEW: clean reset API
    func reset() {
        unlocked.removeAll()
        UserDefaults.standard.removeObject(forKey: key)
    }
}
