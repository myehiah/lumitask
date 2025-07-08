//
//  CachedImageLoader.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 09/07/2025.
//

import Foundation
import SwiftUI
import SwiftData

@MainActor
class CachedImageLoader: ObservableObject {
    @Published var image: UIImage?

    func load(url: URL, context: ModelContext) async {
        let request = FetchDescriptor<CachedImage>(
            predicate: #Predicate { $0.url == url.absoluteString }
        )

        if let cached = try? context.fetch(request).first,
           let img = UIImage(data: cached.data) {
            self.image = img
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let img = UIImage(data: data) {
                self.image = img
                let cached = CachedImage(url: url.absoluteString, data: data)
                context.insert(cached)
                try context.save()
            }
        } catch {
            print("Image download failed: \(error)")
        }
    }
}

