//
//  PageReference.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 08/07/2025.
//


import Foundation

struct PageReference: Codable, Identifiable {
    let id = UUID()                     // for SwiftUI diffing
    let title: String                   // display in UI
    let pageId: String                  // used to load the page from cache
}
