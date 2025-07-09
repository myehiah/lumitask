//
//  SplashViewModel.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 09/07/2025.
//


import SwiftUI

@MainActor
final class SplashViewModel: ObservableObject {
    @Published var isReady = false
    @Published var rootPage: Page?
    @Published var errorMessage: String?

    private let repository: PageRepositoryProtocol

    init(repository: PageRepositoryProtocol) {
        self.repository = repository
    }

    func loadInitialData() async {
        do {
            let page = try await repository.loadAllPages()
            self.rootPage = page
            self.isReady = true
        } catch {
            self.isReady = true
            self.rootPage = nil
            self.errorMessage = "⚠️ Failed to load initial data: \(error.localizedDescription)"
        }
    }
}
