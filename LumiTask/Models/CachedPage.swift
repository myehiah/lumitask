//
//  CachedPage.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 09/07/2025.
//

import Foundation
import SwiftData

@Model
final class CachedPage {
    @Attribute(.unique) var pageId: String = UUID().uuidString
    var title: String?
    var rawData: Data

    init(title: String?, rawData: Data) {
        self.title = title
        self.rawData = rawData
    }
}
