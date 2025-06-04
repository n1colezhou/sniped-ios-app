//
//  GroupsView.swift
//  Sniped
//
//  Created by Nicole Zhou on 6/4/25.
//


import SwiftUI

struct GroupsView: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var dataManager: DataManager
    @State private var showCreateGroup = false
    @State private var groupName = ""
    
    var body: some View {
        NavigationView {
            VStack {
                if let user = authManager.currentUser, user.groupId != nil {
                    Text("You're in a group!")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                    
                    Text("Group ID: \(user.groupId ?? "")")
                        .font(.caption)
                        .foregroundColor(.secondary)
                } else {
                    VStack(spacing: 20) {
                        Text("Join or Create a Group")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Button("Create Group") {
                            showCreateGroup = true
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
            }
            .navigationTitle("Groups")
        }
        .sheet(isPresented: $showCreateGroup) {
            CreateGroupView()
        }
    }
}
