import SwiftUI

struct GameOverView: View {
    let didWin: Bool
    let score: Int
    let difficulty: Difficulty
    let levelID: Int

    // NEW: separate actions
    let onContinue: () -> Void
    let onCloseToLevels: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 14) {
            Spacer()

            Text(didWin ? "🏆 Level Cleared!" : "💥 Game Over")
                .font(.largeTitle)
                .fontWeight(.heavy)

            Text("\(difficulty.title) • Level \(levelID)")
                .foregroundColor(.secondary)

            Text("Score: \(score)")
                .font(.title2)
                .fontWeight(.bold)

            VStack(spacing: 10) {

                Button {
                    dismiss()
                    onContinue()
                } label: {
                    Text(didWin ? "Continue" : "Save & Back")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(didWin ? .green : .orange)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                }

                Button {
                    dismiss()
                    onCloseToLevels()
                } label: {
                    Text("Close")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.gray.opacity(0.2))
                        .cornerRadius(16)
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
    }
}
