import SwiftUI

struct ContentView: View {

    let colors: [Color] = [.red, .green, .blue]
    let colorNames = ["Red", "Green", "Blue"]

    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var resultMessage = ""

    var body: some View {
        VStack(spacing: 30) {

            Text("Color Matching Game")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Match the color:")
                .font(.title2)

            Text(colorNames[correctAnswer])
                .font(.title)
                .foregroundColor(colors[correctAnswer])

            ForEach(0..<3) { index in
                Button {
                    checkAnswer(index)
                } label: {
                    Rectangle()
                        .fill(colors[index])
                        .frame(height: 60)
                        .cornerRadius(12)
                }
            }

            Text(resultMessage)
                .font(.title2)
                .fontWeight(.semibold)

        }
        .padding()
    }

    func checkAnswer(_ selectedIndex: Int) {
        if selectedIndex == correctAnswer {
            resultMessage = "✅ Correct!"
        } else {
            resultMessage = "❌ Try Again"
        }

        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
