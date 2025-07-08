//
//  AppView.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 08/07/2025.
//

import SwiftUI

struct AppView: View {
    @StateObject var viewModel: PageViewModel

    var body: some View {
        NavigationStack {
            Group {
                if let page = viewModel.currentPage {
                    PageDetailView(page: page)
                }
            }
        }
    }
}

#Preview {
    AppView(viewModel: PageViewModel(repository: .init(remote: RemoteDataSourceImp(),
                                                       local: LocalDataSourceImp())))
}

//import SwiftUI
//
//struct AppView: View {
//    
//    @StateObject var viewModel: PageViewModel
//
//    var body: some View {
////        Text("Hello LumiTask")
////        Text(viewModel.currentPage?.id.uuidString ?? "")
////        Text(viewModel.currentPage?.type ?? "")
////        Text(viewModel.currentPage?.title ?? "")
////        Text(viewModel.currentPage?.items?.count.description ?? "")
//        if let page = viewModel.currentPage {
//            ScrollView {
////                NavigationStack {
////                    List {
//                        ItemView(item: .page(page)) // ✅ wrap Page inside .page(Item)
////                    }
////                }
//            }
//        }
//    }
//}
//
//#Preview {
//    AppView(viewModel: PageViewModel(repository: .init(remote: RemoteDataSourceImp(),
//                                                       local: LocalDataSourceImp())))
//}

struct ItemView: View {
    let item: Item?

    var body: some View {
        Group {
            switch item {
            case .page(let page):
//                VStack(alignment: .leading, spacing: 10) {
//                    Text(page.title ?? "")
//                        .font(.title)
//                        .bold()
//                    ForEach(page.items ?? []) { subItem in
//                        ItemView(item: subItem)
//                    }
//                }
//                .padding(.vertical)
                NavigationLink(
                    destination: PageDetailView(page: page)
                ) {
                    HStack {
                        Image(systemName: "doc.text")
                        Text(page.title ?? "")
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
                }

            case .section(let section):
                VStack(alignment: .leading, spacing: 8) {
                    Text(section.title ?? "")
                        .font(.title2)
                        .bold()
                    ForEach(section.items ?? []) { subItem in
                        ItemView(item: subItem)
                    }
                }
                .padding(.vertical)

            case .text(let text):
                Text(text.title ?? "")
                    .font(.body)
                    .padding(.vertical, 4)

//            case .image(let image):
////                Text(image.src ?? "")
////                    .font(.body)
////                    .padding(.vertical, 4)
//
//                NavigationLink(
//                    destination: ImageDetailView(imageURL: image.src ?? "", title: image.title ?? "")
//                ) {
//                    VStack(alignment: .leading) {
//                        AsyncImage(url: URL(string: image.src ?? "")) { phase in
//                            if let img = phase.image {
//                                img
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(height: 150)
//                            } else {
//                                ProgressView()
//                            }
//                        }
//                        Text(image.title ?? "").font(.caption)
//                    }
//                }
            case .image(let image):
                if let src = image.src, let url = URL(string: src) {
                    NavigationLink(
                        destination: ImageDetailView(imageURL: image.src ?? "", title: image.title ?? "")
                    )
                    {
                        VStack(alignment: .leading) {
                            SwiftDataImageView(url: url)
                            Text(image.title ?? "")
                                .font(.caption)
                                .padding(.top, 2)
                        }
                        .padding(.vertical, 4)
                    }
                }

//            case .pageReference(let ref): // ✅ Navigate to sub page
//                NavigationLink(
//                    destination: PageDetailView(page: page)
//                ) {
//                    HStack {
//                        Image(systemName: "doc.text")
//                        Text(ref.title)
//                    }
//                    .padding()
//                    .background(Color.blue.opacity(0.1))
//                    .cornerRadius(8)
//                }

            case .none:
                Text("NO ITEMS FOUND")
                    .font(.body)
                    .padding(.vertical, 4)
            }
        }
    }
}

//struct ItemView: View {
//    let item: Item?
//
//    var body: some View {
//        Group {
//            switch item {
//            case .page(let page):
////                VStack(alignment: .leading, spacing: 10) {
////                    Text("Page: \(page.title ?? "")")
////                        .font(.title)
////                        .bold()
////                    ForEach(page.items ?? []) { subItem in
////                        ItemView(item: subItem)
////                    }
////                }
////                .padding(.vertical)
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
//                Text(image.src ?? "")
//                    .font(.body)
//                    .padding(.vertical, 4)
////                NavigationLink(destination: ImageDetailView(imageURL: image.src, title: image.title)) {
////                    VStack(alignment: .leading) {
////                        AsyncImage(url: URL(string: image.src)) { phase in
////                            if let img = phase.image {
////                                img
////                                    .resizable()
////                                    .scaledToFit()
////                                    .frame(height: 150)
////                                    .cornerRadius(8)
////                            } else {
////                                ProgressView()
////                            }
////                        }
////                        Text(image.title)
////                            .font(.caption)
////                            .padding(.top, 2)
////                    }
////                    .padding(.vertical, 4)
////                }
//            case .none:
//                Text("NO ITEMS FOUND")
//                    .font(.body)
//                    .padding(.vertical, 4)
//                
//            }
//        }
//    }
//}

struct PageDetailView: View {
    let page: Page

    var body: some View {
        List {
            ForEach(page.items ?? [], id: \.id) { item in
                ItemView(item: item)
            }
        }
        .navigationTitle(page.title ?? "")
    }
}

