//
//  AppView.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 08/07/2025.
//

import SwiftUI
import SwiftData

struct AppView: View {
    @StateObject var viewModel: PageViewModel

    var body: some View {
        NavigationStack {
                if let page = viewModel.currentPage {
                    PageDetailView(page: page)
            }
        }
    }
}
#Preview {
    do {
        // Load mock JSON from local file
        let url = Bundle.main.url(forResource: "MockPage", withExtension: "json")!
        let data = try Data(contentsOf: url)

        // Inject mock remote
//        let remote = RemoteDataSourceImp()
        let remote = MockRemoteDataSource(mockData: data)

        // Inject in-memory SwiftData
        let schema = Schema([CachedPage.self, CachedImage.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: schema, configurations: [config])
        let context = container.mainContext

        let local = LocalDataSourceImp(context: context)
        let repo = PageRepository(remote: remote, local: local)
        let viewModel = PageViewModel(repository: repo)

        return AppView(viewModel: viewModel)
            .modelContainer(container)

    } catch {
        return Text("❌ Failed preview: \(error.localizedDescription)")
    }
}

struct ItemView: View {
//    @ObservedObject var viewModel: PageViewModel
    let item: Item?

    var body: some View {
        Group {
            switch item {
            case .page(let page):
                pageView(page)
                
            case .section(let section):
                sectionView(section)
                
            case .text(let text):
                textView(text)
                
            case .image(let image):
                imageView(image)
                
            case .pageReference(let ref):
                pageReferenceView(ref)
                
            case .none:
                noItemView
            }
        }
    }
        // MARK: - Extracted Views
        private func pageView(_ page: Page) -> some View {
//            VStack(alignment: .leading, spacing: 10) {
//                Text(page.title ?? "")
//                    .font(.title)
//                    .bold()
//                ForEach(page.items ?? []) { subItem in
//                    ItemView(item: subItem)
//                }
//            }
//            .padding(.vertical)
            NavigationLink(destination: PageDetailView(page: page)) {
                HStack {
                    Image(systemName: "doc.text")
                    Text(page.title ?? "")
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(8)
            }
        }

        private func sectionView(_ section: Section) -> some View {
            VStack(alignment: .leading, spacing: 8) {
                Text(section.title ?? "")
                    .font(.title2)
                    .bold()
                ForEach(section.items ?? []) { subItem in
                    ItemView(item: subItem)
                }
            }
            .padding(.vertical)
        }

        private func textView(_ text: TextQuestion) -> some View {
            Text(text.title ?? "")
                .font(.body)
                .padding(.vertical, 4)
        }

        private func imageView(_ image: ImageQuestion) -> some View {
            Group {
                if let src = image.src, let url = URL(string: src) {
                    NavigationLink(destination: ImageDetailView(imageURL: src, title: image.title ?? "")) {
                        VStack(alignment: .center) {
                            SwiftDataImageView(url: url)
                                .frame(height: 150)
                                .cornerRadius(8)
                            Text(image.title ?? "")
                                .font(.caption)
                        }
                        .padding(.vertical, 4)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }

        private func pageReferenceView(_ ref: PageReference) -> some View {
            // You can customize this based on your actual usage
            HStack {
                Image(systemName: "doc.text")
                Text(ref.title)
            }
            .padding()
            .background(Color.red.opacity(0.5))
            .cornerRadius(8)
        }

        private var noItemView: some View {
            Text("NO ITEMS FOUND")
                .font(.body)
                .padding(.vertical, 4)
        }
    }
//    var body: some View {
//        Group {
//            switch item {
//            case .page(let page):
//                //                VStack(alignment: .leading, spacing: 10) {
//                //                    Text(page.title ?? "")
//                //                        .font(.title)
//                //                        .bold()
//                //                    ForEach(page.items ?? []) { subItem in
//                //                        ItemView(item: subItem)
//                //                    }
//                //                }
//                //                .padding(.vertical)
//                NavigationLink(
//                    destination: PageDetailView(page: page)
//                ) {
//                    HStack {
//                        Image(systemName: "doc.text")
//                        Text(page.title ?? "")
//                    }
//                    .padding()
//                    .background(Color.blue.opacity(0.1))
//                    .cornerRadius(8)
//                }
//                
//            case .section(let section):
//                VStack(alignment: .leading, spacing: 8) {
//                    Text(section.title ?? "")
//                        .font(.title2)
//                        .bold()
//                    ForEach(section.items ?? []) { subItem in
//                        ItemView(item: subItem)
//                    }
//                }
//                .padding(.vertical)
//                
//            case .text(let text):
//                Text(text.title ?? "")
//                    .font(.body)
//                    .padding(.vertical, 4)
//
//            case .image(let image):
//                if let src = image.src, let url = URL(string: src) {
//                    NavigationLink(
//                        destination: ImageDetailView(imageURL: image.src ?? "", title: image.title ?? "")
//                    )
//                    {
//                        VStack(alignment: .center) {
//                            SwiftDataImageView(url: url)
//                                .frame(height: 150)
//                                .cornerRadius(8)
//                            Text(image.title ?? "")
//                                .font(.caption)
//                            //                                .padding(.top, 2)
//                        }
//                        .padding(.vertical, 4)
//                    }
//                    .frame(maxWidth: .infinity, alignment: .center) // Ensures full width + left aligned
//                }
//                
//            case .pageReference(let ref): // ✅ Navigate to sub page
////                NavigationLink(
////                    destination: PageDetailView(page: viewModel.currentPage)
////                ) {
//////                    Button("Open page") {
//////                        viewModel.loadPage(with: ref)
//////                    }
////                    HStack {
////                        Image(systemName: "doc.text")
////                        Text(ref.title)
////                    }
////                    .padding()
////                    .background(Color.blue.opacity(0.1))
////                    .cornerRadius(8)
////                }
//
//            case .none:
//                Text("NO ITEMS FOUND")
//                    .font(.body)
//                    .padding(.vertical, 4)
//            }
//        }

struct PageDetailView: View {
//    @ObservedObject var viewModel: PageViewModel
    let page: Page

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 16) {
                ForEach(page.items ?? [], id: \.id) { item in
                    ItemView(item: item)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading) // Ensures full width + left aligned
            .padding(.horizontal, 16) // Optional: Better spacing
            .tint(.black)
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .navigationTitle(page.title ?? "")
    }
}

