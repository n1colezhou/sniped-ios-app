//
//  CameraView.swift
//  Sniped
//
//  Created by Nicole Zhou on 6/4/25.
//


import SwiftUI

struct CameraView: View {
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var showPostPreview = false
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)
                        .padding()
                    
                    Button("Post Snipe") {
                        showPostPreview = true
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                } else {
                    VStack(spacing: 20) {
                        Image(systemName: "camera")
                            .font(.system(size: 80))
                            .foregroundColor(.gray)
                        
                        Text("Take a Snipe!")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Button("Open Camera") {
                            showImagePicker = true
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
            }
            .navigationTitle("Camera")
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
        .sheet(isPresented: $showPostPreview) {
            if let image = selectedImage {
                PostPreviewView(image: image) {
                    selectedImage = nil
                    showPostPreview = false
                }
            }
        }
    }
}
