import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var profileStore: ProfileStore

    var body: some View {
        NavigationStack {
            VStack(spacing: 18) {
                Spacer()

                VStack(spacing: 10) {
                    Text("🎨 Color Matching")
                        .font(.largeTitle)
                        .fontWeight(.heavy)

                    HStack(spacing: 10) {
                        Circle()
                            .fill(profileStore.profile.avatarToken.color)
                            .frame(width: 14, height: 14)

                        Text("Hi, \(profileStore.profile.name)")
                            .foregroundColor(.secondary)
                    }
                }

                VStack(spacing: 14) {
                    NavigationLink {
                        LevelSelectView()
                    } label: {
                        mainButton("Play", icon: "gamecontroller.fill")
                    }

                    NavigationLink {
                        LeaderboardView()
                    } label: {
                        mainButton("Leaderboard", icon: "trophy.fill")
                    }

                    NavigationLink {
                        ProfileView()
                    } label: {
                        mainButton("Profile", icon: "person.fill")
                    }

                    NavigationLink {
                        SettingsView()
                    } label: {
                        mainButton("Settings", icon: "gearshape.fill")
                    }
                }
                .padding(.top, 10)

                Spacer()

                Text("Tip: Use Hint 🧠 and Freeze 🧊 wisely.")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 10)
            }
            .padding()
        }
    }

    private func mainButton(_ title: String, icon: String) -> some View {
        HStack {
            Image(systemName: icon)
            Text(title).fontWeight(.bold)
            Spacer()
            Image(systemName: "chevron.right").foregroundColor(.secondary)
        }
        .foregroundColor(.white)
        .padding()
        .background(.black.opacity(0.85))
        .cornerRadius(16)
        .shadow(radius: 6)
    }
}

#Preview {
    HomeView().environmentObject(ProfileStore())
}
