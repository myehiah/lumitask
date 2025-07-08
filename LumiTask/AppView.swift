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
        Text("Hello LumiTask")
        Text(viewModel.currentPage?.id.uuidString ?? "")
        Text(viewModel.currentPage?.type ?? "")
        Text(viewModel.currentPage?.title ?? "")
        Text(viewModel.currentPage?.items?.count.description ?? "")
    }
}

#Preview {
    AppView(viewModel: PageViewModel(repository: .init(remote: RemoteDataSourceImp(),
                                                       local: LocalDataSourceImp())))
}
