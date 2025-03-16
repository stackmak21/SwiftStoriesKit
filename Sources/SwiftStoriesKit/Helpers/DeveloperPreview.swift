//
//  DeveloperPreview.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 16/3/25.
//


import SwiftUI
import Foundation

public struct DeveloperPreview{
    
    public static var stories:  [StoryItemBundle] {
        let story1 = StoryItemBundle(
            id: "1234",
            url: [
                "https://picsum.photos/800/1006",
                "https://picsum.photos/800/1007",
                "https://picsum.photos/800/1008"
            ],
            previewUrl: "https://picsum.photos/800/1009"
        )
        let story2 = StoryItemBundle(
            id: "12345",
            url: [
                "https://picsum.photos/800/1006",
                "https://picsum.photos/800/1007",
                "https://picsum.photos/800/1008"
            ],
            previewUrl: "https://picsum.photos/800/1009"
        )
        let story3 = StoryItemBundle(
            id: "123456",
            url: [
                "https://picsum.photos/800/1006",
                "https://picsum.photos/800/1007",
                "https://picsum.photos/800/1008"
            ],
            previewUrl: "https://picsum.photos/800/1009"
        )
        return [story1, story2, story3]
    }
}
