import SwiftUI

// Important: SwiftUI Color is NOT reliably Equatable.
// So we compare using tokens (enum raw values).
enum ColorToken: String, CaseIterable, Codable, Identifiable {
    case red, green, blue, yellow, orange, purple, pink, cyan, mint, indigo, teal, brown, gray

    var id: String { rawValue }

    var color: Color {
        switch self {
        case .red: return .red
        case .green: return .green
        case .blue: return .blue
        case .yellow: return .yellow
        case .orange: return .orange
        case .purple: return .purple
        case .pink: return .pink
        case .cyan: return .cyan
        case .mint: return .mint
        case .indigo: return .indigo
        case .teal: return .teal
        case .brown: return .brown
        case .gray: return .gray
        }
    }

    var name: String {
        rawValue.capitalized
    }
}
