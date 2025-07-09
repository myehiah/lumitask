//
//  SplashRouter.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 08/07/2025.
//

import SwiftUI
import SwiftData

final class SplashRouter {
    @MainActor static func create(context: ModelContext) -> some View {
        let remote = RemoteDataSourceImp()
        let local = LocalDataSourceImp(context: context)
        let repository = PageRepository(remote: remote, local: local)
        let viewModel = SplashViewModel(repository: repository)
        let screen = SplashView(context: context, viewModel: viewModel)
        return screen
    }
}
