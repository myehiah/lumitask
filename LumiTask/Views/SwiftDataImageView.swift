//
//  SwiftDataImageView.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 09/07/2025.
//

import SwiftUI
import SwiftData

struct SwiftDataImageView: View {
    let url: URL

    @Environment(\.modelContext) private var context
    @StateObject private var loader = CachedImageLoader()

    var body: some View {
        Group {
            if let img = loader.image {
                Image(uiImage: img)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .cornerRadius(8)
            } else {
                ProgressView()
            }
        }
        .task {
            await loader.load(url: url, context: context)
        }
    }
}
