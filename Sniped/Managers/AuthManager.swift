//
//  AuthManager.swift
//  Sniped
//
//  Created by Nicole Zhou on 6/4/25.
//


import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AuthManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    
    private let db = Firestore.firestore()
    
    init() {
        Auth.auth().addStateDidChangeListener { _, user in
            self.isAuthenticated = user != nil
            if let user = user {
                self.loadCurrentUser(uid: user.uid)
            }
        }
    }
    
    func signIn(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func signUp(email: String, password: String, displayName: String) async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        let user = User(
            id: result.user.uid,
            email: email,
            displayName: displayName,
            groupId: nil,
            createdAt: Date()
        )
        try await saveUser(user)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
        currentUser = nil
    }
    
    private func loadCurrentUser(uid: String) {
        db.collection("users").document(uid).getDocument { snapshot, error in
            if let data = snapshot?.data() {
                self.currentUser = try? Firestore.Decoder().decode(User.self, from: data)
            }
        }
    }
    
    private func saveUser(_ user: User) async throws {
        try db.collection("users").document(user.id).setData(from: user)
    }
}
