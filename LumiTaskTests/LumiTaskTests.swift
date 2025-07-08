//
//  LumiTaskTests.swift
//  LumiTaskTests
//
//  Created by Mohamed Yehia on 04/07/2025.
//

import Testing
import Foundation
@testable import LumiTask

struct LumiTaskTests {

    @Test func parseJSON() async throws {
        let json = """
        {
            "type":"page",
            "title":"Main Page",
            "items":[
                {
                    "type":"section",
                    "title":"Introduction",
                    "items":[]
                },
                {
                    "type":"text",
                    "title":"Welcome!"
                }
            ]
        }
        """.data(using: .utf8)!

        let page = try JSONDecoder().decode(Page.self, from: json)

        #expect(page.title == "Main Page")
        #expect(page.items?.count == 2)

        if case .section(let section) = page.items?[0] {
            #expect(section.title == "Introduction")
        } else {
            #expect(Bool(false), "First item should be a section")
        }

        if case .text(let text) = page.items?[1] {
            #expect(text.title == "Welcome!")
        } else {
            #expect(Bool(false), "Second item should be text")
        }
    }
    
    @Test func parseJSON2() async throws {
        let json = """
        {
            "type": "page",
            "title": "Main Page",
            "items": [
                {
                    "type": "section",
                    "title": "Introduction",
                    "items": [
                        {
                            "type": "text",
                            "title": "Welcome to the main page!"
                        },
                        {
                            "type": "image",
                            "title": "Welcome Image",
                            "src": "https://robohash.org/280?&set=set4&size=400x400"
                        }
                    ]
                },
                {
                    "type": "section",
                    "title": "Chapter 1",
                    "items": []
                },
                {
                    "type": "page",
                    "title": "Second Page",
                    "items": []
                }
            ]
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let page = try decoder.decode(Page.self, from: json)

        #expect(page.title == "Main Page")
        #expect(page.items?.count == 3)

        if case .section(let introSection) = page.items?[0] {
            #expect(introSection.title == "Introduction")
            #expect(introSection.items?.count == 2)

            if case .text(let textQuestion) = introSection.items?[0] {
                #expect(textQuestion.title == "Welcome to the main page!")
            } else {
                #expect(Bool(false), "Expected text question as first item in section")
            }

            if case .image(let imageQuestion) = introSection.items?[1] {
                #expect(imageQuestion.title == "Welcome Image")
                #expect(imageQuestion.src?.contains("robohash") ?? false)
            } else {
                #expect(Bool(false), "Expected image question as second item in section")
            }

        } else {
            #expect(Bool(false), "Expected first item to be a section")
        }
    }

}
