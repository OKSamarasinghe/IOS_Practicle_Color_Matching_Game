import Foundation

struct Level: Identifiable, Hashable, Codable {
    let id: Int
    let difficulty: Difficulty

    // These make the game more complex per level
    let boxCount: Int
    let gridColumns: Int
    let timeLimit: Int
    let paletteSize: Int
    let targetMatchesNeeded: Int

    static func build(difficulty: Difficulty, id: Int) -> Level {
        // Increase complexity gradually
        let baseBoxes: Int
        let baseTime: Int
        let basePalette: Int
        let cols: Int

        switch difficulty {
        case .easy:
            baseBoxes = 12
            baseTime = 70
            basePalette = 8
            cols = 4
        case .medium:
            baseBoxes = 18
            baseTime = 55
            basePalette = 6
            cols = 5
        case .hard:
            baseBoxes = 30
            baseTime = 40
            basePalette = 5
            cols = 6
        }

        let extraBoxes = min(id * 2, 18)
        let timeDrop = min(id * 2, difficulty == .hard ? 20 : 25)
        let paletteDrop = min(id / 4, 2)

        return Level(
            id: id,
            difficulty: difficulty,
            boxCount: baseBoxes + extraBoxes,
            gridColumns: cols,
            timeLimit: max(baseTime - timeDrop, 15),
            paletteSize: max(basePalette - paletteDrop, 4),
            targetMatchesNeeded: max(6 + id / 2, 6)
        )
    }
}
