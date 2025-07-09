//
//  PageDetailsView.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 09/07/2025.
//

import SwiftUI

struct PageDetailsView: View {
    let page: Page

    var body: some View {
//        NavigationStack {
//            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(page.items, id: \.id) { item in
                        ItemView(item: item)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .tint(.black)
                .scrollTargetLayout()
            }
//            .scrollTargetBehavior(.viewAligned)
//            .navigationTitle(page.title ?? "")
//        }
//    }
}

#Preview {
    do {
        let url = Bundle.main.url(forResource: "MockPage", withExtension: "json")!
        let data = try Data(contentsOf: url)
        let page = try JSONDecoder().decode(Page.self, from: data)
        return PageDetailsView(page: page)
    } catch {
        return Text("❌ Failed preview: \(error.localizedDescription)")
    }
}
