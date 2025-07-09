//
//  PageReference.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 08/07/2025.
//


import Foundation

struct PageReference: Codable, Identifiable {
    let id = UUID()                     
    let title: String
    let pageId: String
}
