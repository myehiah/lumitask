//
//  Item.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 05/07/2025.
//

import Foundation

enum Item: Codable, Identifiable {
    case page(Page)
    case section(Section)
    case text(TextQuestion)
    case image(ImageQuestion)
//    case pageReference(PageReference)

    var id: UUID {
        switch self {
        case .page(let page): return page.id
        case .section(let section): return section.id
        case .text(let text): return text.id
        case .image(let image): return image.id
//        case .pageReference(let ref): return ref.id
        }
    }

    enum CodingKeys: String, CodingKey {
        case type
    }

    enum ItemType: String, Codable {
        case page, section, text, image //, pageReference
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(ItemType.self, forKey: .type)
        let single = try decoder.singleValueContainer()

        switch type {
        case .page: self = .page(try single.decode(Page.self))
        case .section: self = .section(try single.decode(Section.self))
        case .text: self = .text(try single.decode(TextQuestion.self))
        case .image: self = .image(try single.decode(ImageQuestion.self))
//        case .pageReference: self = .pageReference(try single.decode(PageReference.self))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch self {
        case .page(let page):
            try container.encode(ItemType.page, forKey: .type)
            try page.encode(to: encoder)
        case .section(let section):
            try container.encode(ItemType.section, forKey: .type)
            try section.encode(to: encoder)
        case .text(let text):
            try container.encode(ItemType.text, forKey: .type)
            try text.encode(to: encoder)
        case .image(let image):
            try container.encode(ItemType.image, forKey: .type)
            try image.encode(to: encoder)
//        case .pageReference(let ref):
//            try container.encode(ItemType.pageReference, forKey: .type)
//            try ref.encode(to: encoder)
        }
    }
}

