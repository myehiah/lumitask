//
//  CachedPage.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 09/07/2025.
//


import Foundation
import SwiftData

//@Model
//final class CachedPageX {
////    @Attribute(.unique) var pageId: String
//    @Attribute(.unique) var title: String?
//    var rawData: Data
//
//    init(/*pageId: String,*/ title: String?, rawData: Data) {
////        self.pageId = pageId
//        self.title = title
//        self.rawData = rawData
//    }
//}

@Model
final class CachedPage {
    @Attribute(.unique) var pageId: String?
    var title: String?
    var rawData: Data

    init(pageId: String?, title: String?, rawData: Data) {
        self.pageId = pageId
        self.title = title
        self.rawData = rawData
    }
}
