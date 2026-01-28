import Foundation
import Combine

struct PlayerProfile: Codable {
    var name: String = "Player"
    var avatarToken: ColorToken = .mint
    var tutorialCompleted: Bool = false
}

final class ProfileStore: ObservableObject {
    private let key = "playerProfile"

    @Published var profile: PlayerProfile {
        didSet { save() }
    }

    init() {
        self.profile = UserDefaults.standard.codableValue(
            PlayerProfile.self,
            forKey: key,
            default: PlayerProfile()
        )
    }

    func markTutorialCompleted() {
        profile.tutorialCompleted = true
    }

    private func save() {
        UserDefaults.standard.setCodable(profile, forKey: key)
    }
}
