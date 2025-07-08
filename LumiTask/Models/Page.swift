//
//  Page.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 05/07/2025.
//

import Foundation

struct Page: Codable, Identifiable {
    let id: UUID = UUID()
//    var pageId: String = UUID().uuidString  // default generated
    let type: String
    let title: String?
    let items: [Item]?

//    enum CodingKeys: String, CodingKey {
//        case type, title, items
//        // Intentionally skip pageId from decoding
//    }
//
//    init(type: String, title: String, items: [Item], pageId: String = UUID().uuidString) {
//        self.type = type
//        self.title = title
//        self.items = items
//        self.pageId = pageId
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        type = try container.decode(String.self, forKey: .type)
//        title = try container.decode(String.self, forKey: .title)
//        items = try container.decode([Item].self, forKey: .items)
//        pageId = UUID().uuidString  // always assign a fresh one during decoding
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(type, forKey: .type)
//        try container.encode(title, forKey: .title)
//        try container.encode(items, forKey: .items)
//
//        // You can still include pageId when saving back to cache (optional)
//        var fullContainer = encoder.container(keyedBy: AdditionalCodingKeys.self)
//        try fullContainer.encode(pageId, forKey: .pageId)
//    }
//
//    enum AdditionalCodingKeys: String, CodingKey {
//        case pageId
//    }
}

