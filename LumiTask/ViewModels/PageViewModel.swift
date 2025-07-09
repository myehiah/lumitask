//
//  PageViewModel.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 08/07/2025.
//

import Foundation

class PageViewModel: ObservableObject {
    private let repository: PageRepository
    private let page: Page?

    @Published var currentPage: Page?
    @Published var isLoading = false
    @Published var errorMessage: String? = nil

    init(repository: PageRepository, page: Page? = nil) {
        self.repository = repository
        self.page = page
        
        if let page = page {
            self.currentPage = page
        } else {
            Task {
                await loadPage()
            }
        }
    }

    @MainActor
    func loadPage() async {
        isLoading = true
        do {
            let page = try await repository.loadAllPages()
            self.currentPage = page
            self.errorMessage = nil
        } catch {
            self.errorMessage = error.localizedDescription
        }
        self.isLoading = false
    }
}
