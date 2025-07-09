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
            print("⚠️ Failed to load initial data: \(error.localizedDescription)")
            self.isReady = true
            self.rootPage = Page.init(type: "page", title: "", items: [])
        }
    }
}
