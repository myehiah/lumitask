//
//  LocalDataSource.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 08/07/2025.
//

import Foundation
import SwiftData

protocol LocalDataSource {
    func saveAllPages(page: Page, rawData: Data) throws
    func loadAllPages() throws -> Data
}

class LocalDataSourceImp: LocalDataSource {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func saveAllPages(page: Page, rawData: Data) throws {
        let cached = CachedPage(title: page.title, rawData: rawData)
        context.insert(cached)
        try context.save()
    }

    func loadAllPages() throws -> Data {
        let descriptor = FetchDescriptor<CachedPage>()
        guard let root = try context.fetch(descriptor).first else {
            throw NSError(domain: "LocalDataSource", code: 404, userInfo: [NSLocalizedDescriptionKey: "No cached pages"])
        }
        return root.rawData
    }
}
