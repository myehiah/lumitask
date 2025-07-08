//
//  ImageDetailView.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 08/07/2025.
//

import SwiftUI

// Views/ImageDetailView.swift
struct ImageDetailView: View {
    let imageURL: String
    let title: String
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: imageURL)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            Text(title).padding()
        }
        .navigationTitle("Image")
    }
}
