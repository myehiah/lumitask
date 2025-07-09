//
//  PageViewModel.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 08/07/2025.
//

import Foundation

class PageViewModel: ObservableObject {
    private let repository: PageRepository

    @Published var currentPage: Page?
    @Published var isLoading = false
    @Published var errorMessage: String? = nil

    init(repository: PageRepository) {
        self.repository = repository
        Task {
            await loadPage()
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
