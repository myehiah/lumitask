//
//  RemoteDataSource.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 08/07/2025.
//

import Foundation

protocol RemoteDataSource {
    func fetchPages() async throws -> Data
}

class RemoteDataSourceImp: RemoteDataSource  {
    let url = URL(string: "https://mocki.io/v1/f118b9f0-6f84-435e-85d5-faf4453eb72a")!

    func fetchPages() async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}

final class MockRemoteDataSource: RemoteDataSource {
    var mockData: Data

    init(mockData: Data) {
        self.mockData = mockData
    }

    func fetchPages() async throws -> Data {
        return mockData
    }
}

