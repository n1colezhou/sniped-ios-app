//
//  Group.swift
//  Sniped
//
//  Created by Nicole Zhou on 6/4/25.
//


import Foundation

struct Group: Identifiable, Codable {
    let id: String
    let name: String
    let createdBy: String
    let members: [String]
    let createdAt: Date
}
