//
//  SplashView.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 09/07/2025.
//

import SwiftUI
import SwiftData

struct SplashView: View {
    let context: ModelContext
    @StateObject var viewModel: SplashViewModel
    @State private var isAnimating = false

    var body: some View {
        Group {
            if viewModel.isReady, !isAnimating {
                PageRouter.create(context: context, page: viewModel.rootPage)
            } else {
                VStack {
                    Spacer()
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120)
                        .rotationEffect(.degrees(isAnimating ? 360 : 0))
                        .animation(.linear(duration: 2).repeatForever(autoreverses: true), value: isAnimating)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(uiColor: .systemBackground))
                .onAppear {
                    isAnimating = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            isAnimating = false
                        }
                    }
                }
                .task {
                    isAnimating = true
                    await viewModel.loadInitialData()
                }
            }
        }
    }
}
