import SwiftUI

struct GameView: View {

    let difficulty: Difficulty

    @State private var score = 0
    @State private var colors: [Color] = []
    @State private var targetColor: Color = .red

    let columns = Array(repeating: GridItem(.flexible()), count: 4)

    var body: some View {
        VStack(spacing: 20) {

            Text("Score: \(score)")
                .font(.title)
                .fontWeight(.bold)

            Text("Find this color")
                .font(.title2)

            Rectangle()
                .fill(targetColor)
                .frame(width: 100, height: 100)
                .cornerRadius(12)

            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(colors.indices, id: \.self) { index in
                    Rectangle()
                        .fill(colors[index])
                        .frame(height: 70)
                        .cornerRadius(10)
                        .onTapGesture {
                            handleSelection(colors[index])
                        }
                }
            }
            .padding()

            Spacer()
        }
        .onAppear {
            startGame()
        }
        .navigationTitle("Game")
    }

    func startGame() {
        let count = GameModel.gridSize(for: difficulty)
        colors = GameModel.randomColors(count: count)
        targetColor = colors.randomElement() ?? .red
    }

    func handleSelection(_ selectedColor: Color) {
        if selectedColor == targetColor {
            score += 10
        } else {
            score -= 5
        }
        startGame()
    }
}

