//
//  ContentView.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 08/07/2025.
//

import SwiftUI
import SwiftData

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: PageViewModel
    
    var body: some View {
        NavigationStack {
            if let _ = viewModel.errorMessage {
                ErrorView(viewModel: viewModel)
            } else {
                ScrollView {
                    VStack {
                        if let page = viewModel.currentPage {
                            PageDetailsView(page: page)
                                .scrollTargetBehavior(.viewAligned)
                                .navigationTitle(page.title ?? "")
                        } else if viewModel.isLoading {
                            ProgressView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .refreshable {
                    Task.detached {
                        await viewModel.loadPage()
                    }
                }
            }
        }
    }
}

#Preview {
    do {
        let url = Bundle.main.url(forResource: "MockPage", withExtension: "json")!
        let data = try Data(contentsOf: url)
        
        //        let remote = RemoteDataSourceImp()
        let remote = MockRemoteDataSource(mockData: data)
        
        let schema = Schema([CachedPage.self, CachedImage.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: schema, configurations: [config])
        let context = container.mainContext
        
        let local = LocalDataSourceImp(context: context)
        let repo = PageRepository(remote: remote, local: local)
        let viewModel = PageViewModel(repository: repo)
        
        return ContentView(viewModel: viewModel)
            .modelContainer(container)
        
    } catch {
        return Text("❌ Failed preview: \(error.localizedDescription)")
    }
}
