import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var profileStore: ProfileStore
    @EnvironmentObject private var progressStore: ProgressStore
    @EnvironmentObject private var highScoreStore: HighScoreStore
    @EnvironmentObject private var achievementStore: AchievementStore

    @State private var showTutorial = false
    @State private var animateIn = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 28) {

                    // MARK: - HERO HEADER
                    VStack(spacing: 14) {
                        HStack(spacing: 12) {
                            Circle()
                                .fill(profileStore.profile.avatarToken.color)
                                .frame(width: 16, height: 16)
                                .shadow(radius: 6)

                            Text("Hi, \(profileStore.profile.name)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }

                        Text("🎨 Color Matching")
                            .font(.largeTitle)
                            .fontWeight(.heavy)

                        Text("Train your focus. Beat the colors.")
                            .font(.callout)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 20)
                    .opacity(animateIn ? 1 : 0)
                    .offset(y: animateIn ? 0 : 20)

                    // MARK: - MAIN ACTIONS
                    VStack(spacing: 16) {

                        NavigationLink {
                            LevelSelectView()
                        } label: {
                            homeCard(
                                title: "Play",
                                subtitle: "Choose a level",
                                icon: "gamecontroller.fill",
                                gradient: [.purple, .blue]
                            )
                        }

                        NavigationLink {
                            LeaderboardView()
                        } label: {
                            homeCard(
                                title: "Leaderboard",
                                subtitle: "Top scores",
                                icon: "trophy.fill",
                                gradient: [.orange, .red]
                            )
                        }

                        NavigationLink {
                            AchievementsView()
                        } label: {
                            homeCard(
                                title: "Achievements",
                                subtitle: "Your progress",
                                icon: "rosette",
                                gradient: [.green, .mint]
                            )
                        }

                        NavigationLink {
                            ProfileView()
                        } label: {
                            homeCard(
                                title: "Profile",
                                subtitle: "Player info",
                                icon: "person.fill",
                                gradient: [.teal, .cyan]
                            )
                        }

                        NavigationLink {
                            SettingsView()
                        } label: {
                            homeCard(
                                title: "Settings",
                                subtitle: "Game preferences",
                                icon: "gearshape.fill",
                                gradient: [.gray, .black]
                            )
                        }
                    }
                    .opacity(animateIn ? 1 : 0)
                    .offset(y: animateIn ? 0 : 30)

                    // MARK: - TUTORIAL
                    Button {
                        showTutorial = true
                    } label: {
                        Label("How to Play (Tutorial)", systemImage: "book.fill")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 10)
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.6)) {
                animateIn = true
            }

            if profileStore.profile.tutorialCompleted == false {
                showTutorial = true
            }
        }
        .sheet(isPresented: $showTutorial) {
            TutorialView()
                .environmentObject(profileStore)
        }
    }

    // MARK: - CARD COMPONENT
    private func homeCard(
        title: String,
        subtitle: String,
        icon: String,
        gradient: [Color]
    ) -> some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.white)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)

                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.85))
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.white.opacity(0.8))
        }
        .padding()
        .background(
            LinearGradient(
                colors: gradient,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(18)
        .shadow(color: gradient.first!.opacity(0.35), radius: 10, y: 6)
    }
}
