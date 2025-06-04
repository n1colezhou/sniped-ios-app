//
//  User.swift
//  Sniped
//
//  Created by Nicole Zhou on 6/4/25.
//


import Foundation

struct User: Identifiable, Codable {
    let id: String
    let email: String
    let displayName: String
    let groupId: String?
    let createdAt: Date
}
