//
//  CreateGroupView.swift
//  Sniped
//
//  Created by Nicole Zhou on 6/4/25.
//


import SwiftUI

struct CreateGroupView: View {
    @State private var groupName = ""
    @EnvironmentObject var dataManager: DataManager
    @EnvironmentObject var authManager: AuthManager
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Group Name", text: $groupName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Create") {
                    createGroup()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(groupName.isEmpty)
                
                Spacer()
            }
            .navigationTitle("Create Group")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
    
    private func createGroup() {
        guard let user = authManager.currentUser else { return }
        
        Task {
            do {
                let groupId = try await dataManager.createGroup(name: groupName, createdBy: user.id)
                try await dataManager.joinGroup(groupId: groupId, userId: user.id)
                await MainActor.run {
                    presentationMode.wrappedValue.dismiss()
                }
            } catch {
                print("Error creating group: \(error)")
            }
        }
    }
}
