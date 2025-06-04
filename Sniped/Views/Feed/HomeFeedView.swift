//
//  HomeFeedView.swift
//  Sniped
//
//  Created by Nicole Zhou on 6/4/25.
//


import SwiftUI

struct HomeFeedView: View {
    @EnvironmentObject var dataManager: DataManager
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(dataManager.snipes) { snipe in
                        SnipeCardView(snipe: snipe)
                    }
                }
                .padding()
            }
            .navigationTitle("Feed")
            .refreshable {
                if let groupId = authManager.currentUser?.groupId {
                    dataManager.loadSnipes(for: groupId)
                }
            }
        }
        .onAppear {
            if let groupId = authManager.currentUser?.groupId {
                dataManager.loadSnipes(for: groupId)
            }
        }
    }
}
