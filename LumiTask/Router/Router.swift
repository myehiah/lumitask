//
//  Router.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 08/07/2025.
//

import SwiftUI
import SwiftData

//protocol PageRouter {
//    @MainActor static func create() -> some View
//}

final class PageRouterImp {
//    static let shared = Router()

//    // Shared dependencies
//    private let repository: PageRepository
//
//    private init() {
//        let remote = RemoteDataSourceImpl(
//            url: URL(string: "https://mocki.io/v1/f118b9f0-6f84-435e-85d5-faf4453eb72a")!
//        )
//        let container = try! ModelContainer(for: PageEntity.self)
//        let local = SwiftDataLocalDataSource(context: container.mainContext)
//
//        self.repository = PageRepository(remote: remote, local: local)
//    }
//
//    // MARK: - View Factories
//
//    func rootView() -> some View {
//        let vm = PageViewModel(repository: repository)
//        return ContentView()
//            .environmentObject(vm)
//            .modelContainer(try! ModelContainer(for: PageEntity.self))
//    }
//
//    func pageDetailView(pageId: String) -> some View {
//        let vm = PageViewModel(repository: repository)
//        return PageDetailViewWrapper(pageId: pageId, viewModel: vm)
//    }
    
    // MARK: - Config Functions
    @MainActor static func create(context: ModelContext) -> some View {
        let remote = RemoteDataSourceImp()
        let local = LocalDataSourceImp(context: context)
        let repository = PageRepository(remote: remote, local: local)
        let viewModel = PageViewModel(repository: repository)
        let screen = AppView(viewModel: viewModel)
//        let controller = createVC(with: screen)
//        router.screenVC = controller
        return screen
    }
}
