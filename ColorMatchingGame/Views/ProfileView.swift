import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var profileStore: ProfileStore
    @State private var name: String = ""

    var body: some View {
        Form {
            Section("Player") {
                TextField("Your name", text: $name)
                    .onAppear { name = profileStore.profile.name }

                HStack(spacing: 12) {
                    Text("Avatar Color")
                    Spacer()
                    Circle()
                        .fill(profileStore.profile.avatarToken.color)
                        .frame(width: 22, height: 22)
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(ColorToken.allCases) { token in
                            Circle()
                                .fill(token.color)
                                .frame(width: 28, height: 28)
                                .overlay(
                                    Circle().stroke(.white, lineWidth: profileStore.profile.avatarToken == token ? 3 : 0)
                                )
                                .onTapGesture {
                                    profileStore.profile.avatarToken = token
                                    Haptics.light()
                                }
                        }
                    }
                    .padding(.vertical, 6)
                }
            }

            Button("Save") {
                profileStore.profile.name = name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "Player" : name
                Haptics.success()
            }
        }
        .navigationTitle("Profile")
    }
}
