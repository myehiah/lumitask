//
//  ImageDetailView.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 08/07/2025.
//

import SwiftUI

// Views/ImageDetailView.swift
struct ImageDetailView: View {
    let imageURL: String?
    let title: String
    
    var body: some View {
        VStack {
            if let imageURL = imageURL, let url = URL(string: imageURL) {
                SwiftDataImageView(url: url)
            }
            Text(title).padding()
        }
        .navigationTitle("Image")
    }
}
