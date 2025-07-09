//
//  Page.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 05/07/2025.
//

import Foundation

struct Page: Codable, Identifiable {
    let id: UUID = UUID()
    let type: String
    let title: String?
    let items: [Item]
}

