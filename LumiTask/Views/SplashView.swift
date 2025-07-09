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
            if viewModel.isReady, let page = viewModel.rootPage, !isAnimating {
                PageRouter.create(context: context, page: page)
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


//struct SplashView: View {
//    let context: ModelContext
//    @StateObject var viewModel: SplashViewModel
//    @State private var isAnimating = false
//
//    var body: some View {
//        Group {
//            if viewModel.isReady, let page = viewModel.rootPage /*,!isAnimating*/ {
//                PageRouter.create(context: context, page: page)
//            } else {
//                VStack {
//                    Spacer()
//                    Image("logo")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 120)
//                        .rotationEffect(.degrees(isAnimating ? 360 : 0))
//                        .animation(.linear(duration: 2).repeatForever(autoreverses: false), value: isAnimating)
//                    Spacer()
//                }
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .background(Color(uiColor: .systemBackground))
////                .onAppear {
////                    isAnimating = true
////                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
////                        withAnimation {
////                            isAnimating = false
////                        }
////                    }
////                }
//                .task {
//                    await viewModel.loadInitialData()
//                }
//            }
//        }
//    }
//}
