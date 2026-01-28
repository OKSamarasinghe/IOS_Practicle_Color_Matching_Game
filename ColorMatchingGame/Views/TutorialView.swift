import SwiftUI

struct TutorialView: View {
    @EnvironmentObject private var profileStore: ProfileStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Text("🎨 How to Play")
                .font(.largeTitle)
                .fontWeight(.bold)

            VStack(alignment: .leading, spacing: 12) {
                tutorialRow("🎯", "Match the target color")
                tutorialRow("⭐", "Correct taps increase score")
                tutorialRow("💥", "Wrong taps reduce score")
                tutorialRow("🧠", "Use hints wisely")
                tutorialRow("🧊", "Freeze pauses time briefly")
            }
            .padding()

            Button {
                profileStore.markTutorialCompleted()
                dismiss()
            } label: {
                Text("Got it! Let’s Play")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.green)
                    .foregroundColor(.white)
                    .cornerRadius(16)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
    }

    private func tutorialRow(_ icon: String, _ text: String) -> some View {
        HStack {
            Text(icon)
            Text(text)
            Spacer()
        }
    }
}
