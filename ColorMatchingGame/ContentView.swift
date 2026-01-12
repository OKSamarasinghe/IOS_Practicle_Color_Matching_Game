import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {

                Text("Color Matching Game")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Select Difficulty")
                    .font(.title2)

                NavigationLink("Easy") {
                    GameView(difficulty: .easy)
                }
                .buttonStyle(.borderedProminent)

                NavigationLink("Medium") {
                    GameView(difficulty: .medium)
                }
                .buttonStyle(.borderedProminent)

                NavigationLink("Hard") {
                    GameView(difficulty: .hard)
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

#Preview {
    ContentView()
}
