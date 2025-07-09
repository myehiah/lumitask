//
//  PageRepository.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 08/07/2025.
//

import Foundation

protocol PageRepositoryProtocol {
//    func loadAllPages() async throws -> Page
    func loadPage(with id: String) async throws -> Page
}

final class PageRepository: PageRepositoryProtocol {
    private let remote: RemoteDataSource
    private let local: LocalDataSource

    init(remote: RemoteDataSource, local: LocalDataSource) {
        self.remote = remote
        self.local = local
    }
    
    func loadPage(with id: String) async throws -> Page {
        do {
            print("FETCHING")
            let data = try await remote.fetchPages()
            let rootPage = try JSONDecoder().decode(Page.self, from: data)

            // Cache normalized pages
            try cacheAllPages(root: rootPage)

            return rootPage
        }
        catch {
            // Try local cache
            print("TRYING LOCAL CACHE")
            let cachedData = try local.loadPage(id: id)
            let page = try JSONDecoder().decode(Page.self, from: cachedData)
            return page
        }
    }

//    func loadAllPages() async throws -> Page {
//        do {
//            print("FETCHING")
//            let data = try await remote.fetchPages()
//            let rootPage = try JSONDecoder().decode(Page.self, from: data)
//            
//            try local.saveAllPages(page: rootPage, rawData: data)
//            
//            return rootPage
//        }
//        catch {
//            // Try local cache
//            print("TRYING LOCAL CACHE")
//            let cachedData = try local.loadAllPages()
//            let page = try JSONDecoder().decode(Page.self, from: cachedData)
//            return page
//        }
////        do {
////            // Try local cache first
////            let cachedData = try local.loadPage(id: id)
////            let page = try JSONDecoder().decode(Page.self, from: cachedData)
////            return page
////        } catch {
////            // If root page requested, try remote
////            guard id == "root" else { throw error }
////
////            let data = try await remote.fetchPages()
////            let rootPage = try JSONDecoder().decode(Page.self, from: data)
////
////            // Cache normalized pages
////            try cacheAllPages(root: rootPage)
////
////            return rootPage
////        }
//    }

    private func cacheAllPages(root: Page) throws {
        var queue: [Page] = [root]

        while let page = queue.popLast() {
            // Separate nested pages from items
            let (childPages, remainingItems) = separateNestedPages(from: page.items ?? [])

            // Create page with references to nested pages
            let modifiedPage = Page(
                type: page.type,
                title: page.title ?? "",
                items: remainingItems,
                pageId: page.pageId
            )

            let data = try JSONEncoder().encode(modifiedPage)
            try local.savePage(id: modifiedPage.pageId, title: modifiedPage.title ?? "", rawData: data)

            queue.append(contentsOf: childPages)
        }
    }

    private func separateNestedPages(from items: [Item]) -> ([Page], [Item]) {
        var pages: [Page] = []
        var newItems: [Item] = []

        for item in items {
            switch item {
            case .page(let nested):
                pages.append(nested)
                let reference = PageReference(pageId: nested.pageId, title: nested.title ?? "")
                newItems.append(.pageReference(reference))
            default:
                newItems.append(item)
            }
        }

        return (pages, newItems)
    }
//
//    private func processSection(_ section: Section) -> ([Page], Section) {
//        var nestedPages: [Page] = []
//        var newItems: [Item] = []
//
//        for item in section.items {
//            switch item {
//            case .section(let subsection):
//                let (subPages, modifiedSubsection) = processSection(subsection)
//                nestedPages.append(contentsOf: subPages)
//                newItems.append(.section(modifiedSubsection))
//            case .page:
//                // Should never happen, sections can’t contain pages
//                continue
//            default:
//                newItems.append(item)
//            }
//        }
//
//        let updated = Section(id: section.id, title: section.title, items: newItems)
//        return (nestedPages, updated)
//    }
}

