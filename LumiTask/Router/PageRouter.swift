//
//  PageRouter.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 08/07/2025.
//

import SwiftUI
import SwiftData

final class PageRouter {
    @MainActor static func create(context: ModelContext, page: Page?) -> some View {
        let remote = RemoteDataSourceImp()
        let local = LocalDataSourceImp(context: context)
        let repository = PageRepository(remote: remote, local: local)
        let viewModel = PageViewModel(repository: repository, page: page)
        let screen = ContentView(viewModel: viewModel)
        return screen
    }
}
