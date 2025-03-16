//
//  DeveloperPreview.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 16/3/25.
//


import SwiftUI
import Foundation

public struct DeveloperPreview{
    
    public static var story: StoryItemBundle {
        let story = StoryItemBundle(
            id: "1234",
            url: [
                "https://picsum.photos/800/1006",
                "https://picsum.photos/800/1007",
                "https://picsum.photos/800/1008"
            ],
            previewUrl: "https://picsum.photos/800/1011"
        )
        return story
    }
    
    public static var stories:  [StoryItemBundle] {
        let story1 = StoryItemBundle(
            id: "1234",
            url: [
                "https://picsum.photos/800/1006",
                "https://picsum.photos/800/1007",
                "https://picsum.photos/800/1008"
            ],
            previewUrl: "https://picsum.photos/800/1012"
        )
        let story2 = StoryItemBundle(
            id: "12345",
            url: [
                "https://picsum.photos/800/1006",
                "https://picsum.photos/800/1007",
                "https://picsum.photos/800/1008"
            ],
            previewUrl: "https://picsum.photos/800/1013"
        )
        let story3 = StoryItemBundle(
            id: "123456",
            url: [
                "https://picsum.photos/800/1006",
                "https://picsum.photos/800/1007",
                "https://picsum.photos/800/1008"
            ],
            previewUrl: "https://picsum.photos/800/1014"
        )
        
        let story4 = StoryItemBundle(
            id: "1223456",
            url: [
                "https://picsum.photos/800/1006",
                "https://picsum.photos/800/1007",
                "https://picsum.photos/800/1008"
            ],
            previewUrl: "https://picsum.photos/800/1015"
        )
        
        let story5 = StoryItemBundle(
            id: "1234565",
            url: [
                "https://picsum.photos/800/1006",
                "https://picsum.photos/800/1007",
                "https://picsum.photos/800/1008"
            ],
            previewUrl: "https://picsum.photos/800/1017"
        )
        
        let story6 = StoryItemBundle(
            id: "1263456",
            url: [
                "https://picsum.photos/800/1006",
                "https://picsum.photos/800/1007",
                "https://picsum.photos/800/1008"
            ],
            previewUrl: "https://picsum.photos/800/1018"
        )
        
        let story7 = StoryItemBundle(
            id: "12332456",
            url: [
                "https://picsum.photos/800/1006",
                "https://picsum.photos/800/1007",
                "https://picsum.photos/800/1008"
            ],
            previewUrl: "https://picsum.photos/800/1024"
        )
        
        let story8 = StoryItemBundle(
            id: "123453456",
            url: [
                "https://picsum.photos/800/1006",
                "https://picsum.photos/800/1007",
                "https://picsum.photos/800/1008"
            ],
            previewUrl: "https://picsum.photos/800/1023"
        )
        
        let story9 = StoryItemBundle(
            id: "1234422556",
            url: [
                "https://picsum.photos/800/1006",
                "https://picsum.photos/800/1007",
                "https://picsum.photos/800/1008"
            ],
            previewUrl: "https://picsum.photos/800/1029"
        )
        return [story1, story2, story3, story4, story5, story6, story7, story8, story9]
    }
}
