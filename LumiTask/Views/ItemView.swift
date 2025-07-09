//
//  ItemView.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 09/07/2025.
//

import SwiftUI

struct ItemView: View {
    let item: Item
    var level: Int = 0
    
    var body: some View {
        switch item {
        case .page(let page):
            pageView(page)
            
        case .section(let section):
            sectionView(section, level: level)

        case .text(let text):
            textView(text)
            
        case .image(let image):
            imageView(image)
        }
    }
    
    // MARK: - Private Helpers
    private func pageView(_ page: Page) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(page.title ?? "")
                .font(.largeTitle)
                .bold()
            ForEach(page.items) { subItem in
                ItemView(item: subItem)
            }
        }
        .padding(.vertical)
//        NavigationLink(destination: PageDetailsView(page: page)) {
//            HStack {
//                Image(systemName: "doc.text")
//                Text(page.title ?? "")
//            }
//            .padding()
//            .background(Color.blue.opacity(0.1))
//            .cornerRadius(8)
//        }
    }
    
    private func sectionView(_ section: Section, level: Int = 0) -> some View {
        let baseFontSize: CGFloat = 25
        let fontSize = baseFontSize * pow(0.8, CGFloat(level))

        return VStack(alignment: .leading, spacing: 8) {
            Text(section.title ?? "")
                .font(.system(size: fontSize))
                .bold()

            ForEach(section.items) { subItem in
                ItemView(item: subItem, level: level + 1)
            }
        }
        .padding(.vertical)
    }
    
    private func textView(_ text: TextQuestion) -> some View {
        Text(text.title ?? "")
            .font(.subheadline)
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
                            .font(.subheadline)
                    }
                    .padding(.vertical, 4)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}
