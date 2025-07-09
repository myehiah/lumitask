//
//  LocalDataSource.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 08/07/2025.
//

import Foundation
import SwiftData

protocol LocalDataSource {
//    func savePage(id: String, title: String, rawData: Data) throws
//    func loadPage(id: String) throws -> Data
    func saveAllPages(page: Page, rawData: Data) throws
    func loadAllPages() throws -> Data
}

//class LocalDataSourceImp: LocalDataSource  {
//    func savePage(id: String, title: String, rawData: Data) throws {
//        print("Save Page to Local Storage")
//    }
//    
//    func loadPage(id: String) throws -> Data {
//        print("Load Page with id: \(id) from Local Storage")
//        return Data()
//    }
//    
//    func saveAllPages(page: Page, rawData: Data) throws {
//        print("Save All Pages to Local Storage")
//    }
//    
//    func loadAllPages() throws -> Data {
//        print("Load All Pages from Local Storage")
//        return Data()
//    }
//}

class LocalDataSourceImp: LocalDataSource {
    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

//    func savePage(id: String, title: String, rawData: Data) throws {
//        let page = CachedPage(pageId: id, title: title, rawData: rawData)
//        context.insert(page)
//        try context.save()
//    }
//
//    func loadPage(id: String) throws -> Data {
//        let descriptor = FetchDescriptor<CachedPage>(
//            predicate: #Predicate { $0.pageId == id }
//        )
//        guard let cached = try context.fetch(descriptor).first else {
//            throw NSError(domain: "LocalDataSource", code: 404, userInfo: [NSLocalizedDescriptionKey: "Page not found in cache"])
//        }
//        return cached.rawData
//    }

    func saveAllPages(page: Page, rawData: Data) throws {
//        guard let id = page.pageId else {
//            throw NSError(domain: "LocalDataSource", code: 500, userInfo: [NSLocalizedDescriptionKey: "Page ID is missing"])
//        }
        let cached = CachedPage(/*pageId: id,*/ title: page.title, rawData: rawData)
        context.insert(cached)
        try context.save()
                print("SAVED ALL PAGES to Local Storage")
    }

    func loadAllPages() throws -> Data {
        let descriptor = FetchDescriptor<CachedPage>()
        guard let root = try context.fetch(descriptor).first else {
            throw NSError(domain: "LocalDataSource", code: 404, userInfo: [NSLocalizedDescriptionKey: "No cached pages"])
        }
        return root.rawData
    }
}
