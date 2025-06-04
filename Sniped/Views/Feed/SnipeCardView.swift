//
//  SnipeCardView.swift
//  Sniped
//
//  Created by Nicole Zhou on 6/4/25.
//


import SwiftUI

struct SnipeCardView: View {
    let snipe: Snipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(snipe.authorName)
                    .fontWeight(.semibold)
                Spacer()
                Text(snipe.createdAt, style: .relative)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            AsyncImage(url: URL(string: snipe.imageURL)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .aspectRatio(1, contentMode: .fit)
            }
            .cornerRadius(12)
            
            if !snipe.caption.isEmpty {
                Text(snipe.caption)
                    .font(.body)
            }
            
            HStack {
                Button(action: {}) {
                    Image(systemName: "heart")
                }
                Button(action: {}) {
                    Image(systemName: "message")
                }
                Spacer()
            }
            .foregroundColor(.primary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 2)
    }
}
