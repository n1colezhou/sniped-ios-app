//
//  NotificationsView.swift
//  Sniped
//
//  Created by Nicole Zhou on 6/4/25.
//


import SwiftUI

struct NotificationsView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("No new notifications")
                    .foregroundColor(.secondary)
            }
            .navigationTitle("Notifications")
        }
    }
}
