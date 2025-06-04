//
//  PostPreviewView.swift
//  Sniped
//
//  Created by Nicole Zhou on 6/4/25.
//


import SwiftUI

struct PostPreviewView: View {
    let image: UIImage
    let onPost: () -> Void
    @State private var caption = ""
    @State private var isPosting = false
    @EnvironmentObject var dataManager: DataManager
    @EnvironmentObject var authManager: AuthManager
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(12)
                    .padding()
                
                TextField("Add a caption...", text: $caption)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Post Snipe")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Post") {
                    postSnipe()
                }
                .disabled(isPosting)
            )
        }
    }
    
    private func postSnipe() {
        guard let user = authManager.currentUser,
              let groupId = user.groupId else { return }
        
        isPosting = true
        
        Task {
            do {
                try await dataManager.uploadSnipe(
                    image: image,
                    caption: caption,
                    authorId: user.id,
                    authorName: user.displayName,
                    groupId: groupId
                )
                await MainActor.run {
                    onPost()
                }
            } catch {
                print("Error posting snipe: \(error)")
            }
            await MainActor.run {
                isPosting = false
            }
        }
    }
}
