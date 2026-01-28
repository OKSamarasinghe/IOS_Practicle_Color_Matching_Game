import Foundation

extension UserDefaults {
    func setCodable<T: Codable>(_ value: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(value) {
            set(data, forKey: key)
        }
    }

    func codableValue<T: Codable>(_ type: T.Type, forKey key: String, default defaultValue: T) -> T {
        guard let data = data(forKey: key),
              let decoded = try? JSONDecoder().decode(type, from: data) else {
            return defaultValue
        }
        return decoded
    }
}
