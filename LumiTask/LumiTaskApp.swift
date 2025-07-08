//
//  LumiTaskApp.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 04/07/2025.
//

import SwiftUI
import SwiftData

@main
struct LumiTaskApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            ItemX.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()

    var body: some Scene {
        WindowGroup {
            PageRouterImp.create()
//            AppView(viewModel: pageVieModel)
//            ContentView()
        }
        .modelContainer(for: CachedImage.self)
//        .modelContainer(sharedModelContainer)
    }
}

