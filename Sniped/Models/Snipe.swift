//
//  Snipe.swift
//  Sniped
//
//  Created by Nicole Zhou on 6/4/25.
//


import Foundation

struct Snipe: Identifiable, Codable {
    let id: String
    let imageURL: String
    let caption: String
    let authorId: String
    let authorName: String
    let groupId: String
    let taggedUsers: [String]
    let createdAt: Date
    let reactions: [String: String] // userId: reaction
}
