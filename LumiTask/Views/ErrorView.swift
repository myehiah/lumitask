//
//  ErrorView.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 10/07/2025.
//

import SwiftUI

struct ErrorView: View {
    @ObservedObject var viewModel: PageViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(height: 120)
            
            Text("Oops! Something went wrong.")
                .font(.title3)
                .fontWeight(.semibold)
            
            Text(viewModel.errorMessage ?? "")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button("Retry") {
                Task.detached {
                    await viewModel.loadPage()
                }                        }
            .padding(.top, 8)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
