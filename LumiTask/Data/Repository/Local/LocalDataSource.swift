//
//  LocalDataSource.swift
//  LumiTask
//
//  Created by Mohamed Yehia on 08/07/2025.
//

import Foundation

protocol LocalDataSource {
    func savePage(id: String, title: String, rawData: Data) throws
    func loadPage(id: String) throws -> Data
    func saveAllPages(page: Page, rawData: Data) throws
    func loadAllPages() throws -> Data
}

class LocalDataSourceImp: LocalDataSource  {
    func savePage(id: String, title: String, rawData: Data) throws {
        print("Save Page to Local Storage")
    }
    
    func loadPage(id: String) throws -> Data {
        print("Load Page with id: \(id) from Local Storage")
        return Data()
    }
    
    func saveAllPages(page: Page, rawData: Data) throws {
        print("Save All Pages to Local Storage")
    }
    
    func loadAllPages() throws -> Data {
        print("Load All Pages from Local Storage")
        return Data()
    }
}
