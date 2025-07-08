//
//  CachedImage.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 09/07/2025.
//

import Foundation
import SwiftData

@Model
final class CachedImage {
    @Attribute(.unique) var url: String
    var data: Data

    init(url: String, data: Data) {
        self.url = url
        self.data = data
    }
}
