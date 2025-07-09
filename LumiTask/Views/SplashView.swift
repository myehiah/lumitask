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
    @State private var isAnimating = false
    @State private var isFinished = false

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()

            if !isFinished {
                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .rotationEffect(.degrees(isAnimating ? 360 : 0))
                        .animation(
                            .linear(duration: 2).repeatForever(autoreverses: false),
                            value: isAnimating
                        )
                }
                .onAppear {
                    isAnimating = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            isFinished = true
                        }
                    }
                }
            } else {
                PageRouter.create(context: context)
            }
        }
    }
}
