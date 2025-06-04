//
//  DataManager.swift
//  Sniped
//
//  Created by Nicole Zhou on 6/4/25.
//


import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

class DataManager: ObservableObject {
    @Published var snipes: [Snipe] = []
    @Published var currentGroup: Group?
    
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    func loadSnipes(for groupId: String) {
        db.collection("snipes")
            .whereField("groupId", isEqualTo: groupId)
            .order(by: "createdAt", descending: true)
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else { return }
                self.snipes = documents.compactMap { doc in
                    try? doc.data(as: Snipe.self)
                }
            }
    }
    
    func createGroup(name: String, createdBy: String) async throws -> String {
        let group = Group(
            id: UUID().uuidString,
            name: name,
            createdBy: createdBy,
            members: [createdBy],
            createdAt: Date()
        )
        try db.collection("groups").document(group.id).setData(from: group)
        return group.id
    }
    
    func joinGroup(groupId: String, userId: String) async throws {
        try await db.collection("groups").document(groupId).updateData([
            "members": FieldValue.arrayUnion([userId])
        ])
    }
    
    func uploadSnipe(image: UIImage, caption: String, authorId: String, authorName: String, groupId: String) async throws {
        // Upload image to Firebase Storage
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        let imageRef = storage.reference().child("snipes/\(UUID().uuidString).jpg")
        let _ = try await imageRef.putDataAsync(imageData)
        let downloadURL = try await imageRef.downloadURL()
        
        // Save snipe to Firestore
        let snipe = Snipe(
            id: UUID().uuidString,
            imageURL: downloadURL.absoluteString,
            caption: caption,
            authorId: authorId,
            authorName: authorName,
            groupId: groupId,
            taggedUsers: [],
            createdAt: Date(),
            reactions: [:]
        )
        
        try db.collection("snipes").document(snipe.id).setData(from: snipe)
    }
}
