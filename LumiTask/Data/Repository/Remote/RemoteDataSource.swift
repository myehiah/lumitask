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
    private var url: URL {
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String,
              let url = URL(string: urlString) else {
            fatalError("❌ Missing or invalid API_BASE_URL in Info.plist")
        }
        return url
    }
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

