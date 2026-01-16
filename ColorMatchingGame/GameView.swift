import SwiftUI
import Combine

struct GameView: View {

    let difficulty: Difficulty

    @State private var score = 0
    @State private var colors: [Color] = []
    @State private var targetColor: Color = .red
    @State private var timeRemaining = 0
    @State private var timer: AnyCancellable?

    // MARK: Grid Columns
    var columns: [GridItem] {
        switch difficulty {
        case .easy:
            return Array(repeating: GridItem(.flexible()), count: 5)
        case .medium:
            return Array(repeating: GridItem(.flexible()), count: 5)
        case .hard:
            return Array(repeating: GridItem(.flexible()), count: 6)
        }
    }

    var title: String {
        switch difficulty {
        case .easy: return "Easy Mode"
        case .medium: return "Medium Mode"
        case .hard: return "Hard Mode"
        }
    }

    var body: some View {
        VStack(spacing: 16) {

            // TOP INFO BAR
            HStack {
                Text("⏱ \(formattedTime)")
                    .fontWeight(.bold)
                    .foregroundColor(timeRemaining <= 10 ? .red : .primary)

                Spacer()

                Text("Score: \(score)")
                    .fontWeight(.bold)
            }
            .padding(.horizontal)

            Text("Match This Color")
                .font(.title3)
                .fontWeight(.semibold)

            RoundedRectangle(cornerRadius: 18)
                .fill(targetColor)
                .frame(width: 110, height: 110)
                .shadow(radius: 6)

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(colors.indices, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 12)
                        .fill(colors[index])
                        .frame(height: 55)
                        .shadow(radius: 3)
                        .onTapGesture {
                            handleTap(colors[index])
                        }
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding(.top)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            startGame()
            startTimer()
        }
        .onDisappear {
            timer?.cancel()
        }
    }

    // MARK: - Game Logic
    func startGame() {
        colors = GameModel.generateColors(for: difficulty)
        targetColor = colors.randomElement() ?? .red
    }

    func handleTap(_ selected: Color) {
        if selected == targetColor {
            score += difficulty == .hard ? 20 : 10
        } else {
            score -= difficulty == .hard ? 15 : 5
        }

        // Reshuffle every tap
        startGame()
    }

    // MARK: - Timer
    func startTimer() {
        timeRemaining = GameModel.timeLimit(for: difficulty)

        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    timer?.cancel()
                }
            }
    }

    var formattedTime: String {
        String(format: "%02d:%02d", timeRemaining / 60, timeRemaining % 60)
    }
}
