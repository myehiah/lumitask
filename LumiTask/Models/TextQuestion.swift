//
//  TextQuestion.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 05/07/2025.
//

import Foundation

struct TextQuestion: Codable, Identifiable {
    let id = UUID()
    let type: String
    let title: String?
}
