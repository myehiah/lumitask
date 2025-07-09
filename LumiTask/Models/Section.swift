//
//  Section.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 05/07/2025.
//

import Foundation

struct Section: Codable, Identifiable, Equatable {
    let id = UUID()
    let type: String
    let title: String?
    let items: [Item]
}
