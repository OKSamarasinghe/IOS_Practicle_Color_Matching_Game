import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {

                Spacer()

                Text("🎨 Color Matching Game")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Choose Difficulty")
                    .font(.title3)
                    .foregroundColor(.gray)

                VStack(spacing: 20) {

                    NavigationLink {
                        GameView(difficulty: .easy)
                    } label: {
                        difficultyButton(title: "Easy", color: .green)
                    }

                    NavigationLink {
                        GameView(difficulty: .medium)
                    } label: {
                        difficultyButton(title: "Medium", color: .orange)
                    }

                    NavigationLink {
                        GameView(difficulty: .hard)
                    } label: {
                        difficultyButton(title: "Hard", color: .red)
                    }
                }

                Spacer()
            }
            .padding()
        }
    }

    func difficultyButton(title: String, color: Color) -> some View {
        Text(title)
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
            .cornerRadius(15)
            .shadow(radius: 5)
    }
}

#Preview {
    ContentView()
}
