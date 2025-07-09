//
//  PageRepository.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 08/07/2025.
//

import Foundation

protocol PageRepositoryProtocol {
    func loadAllPages() async throws -> Page
}

final class PageRepository: PageRepositoryProtocol {
    private let remote: RemoteDataSource
    private let local: LocalDataSource

    init(remote: RemoteDataSource, local: LocalDataSource) {
        self.remote = remote
        self.local = local
    }

    func loadAllPages() async throws -> Page {
        do {
            let data = try await remote.fetchPages()
            let rootPage = try JSONDecoder().decode(Page.self, from: data)
            try local.saveAllPages(page: rootPage, rawData: data)
            return rootPage
        }
        catch {
            let cachedData = try local.loadAllPages()
            let page = try JSONDecoder().decode(Page.self, from: cachedData)
            return page
        }
    }
}

