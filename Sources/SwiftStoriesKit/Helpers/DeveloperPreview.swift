// DeveloperPreview.swift
// SwiftStoriesKit
//
// Created by Paris Makris on 16/3/25.
//

import SwiftUI
import Foundation

public struct DeveloperPreview {
    
    public static var story: StoryBundle {
        let story = StoryBundle(
            id: "1234",
            stories: [
                Story(imageURL: "https://picsum.photos/800/1006"),
                Story(imageURL: "https://picsum.photos/800/1007"),
                Story(imageURL: "https://picsum.photos/800/1008")
            ],
            previewUrl: "https://picsum.photos/800/1011",
            type: .photo, // Assuming type is .photo, you can change this as needed
            creator: Creator() // Assuming a default creator is acceptable
        )
        return story
    }
    
    public static var stories: [StoryBundle] {
        let story1 = StoryBundle(
            id: "1234",
            stories: [
                Story(imageURL: "https://picsum.photos/800/1001"),
                Story(imageURL: "https://picsum.photos/800/1007"),
                Story(imageURL: "https://picsum.photos/800/1008")
            ],
            previewUrl: "https://picsum.photos/800/1012",
            type: .photo, // Again, assuming .photo for media type
            creator: Creator()
        )
        
        let story2 = StoryBundle(
            id: "12345",
            stories: [
                Story(imageURL: "https://picsum.photos/800/1002"),
                Story(imageURL: "https://picsum.photos/800/1007"),
                Story(imageURL: "https://picsum.photos/800/1008")
            ],
            previewUrl: "https://picsum.photos/800/1013",
            type: .photo,
            creator: Creator()
        )
        
        let story3 = StoryBundle(
            id: "123456",
            stories: [
                Story(imageURL: "https://picsum.photos/800/1003"),
                Story(imageURL: "https://picsum.photos/800/1007"),
                Story(imageURL: "https://picsum.photos/800/1008")
            ],
            previewUrl: "https://picsum.photos/800/1014",
            type: .photo,
            creator: Creator()
        )
        
        let story4 = StoryBundle(
            id: "1223456",
            stories: [
                Story(imageURL: "https://picsum.photos/800/1004"),
                Story(imageURL: "https://picsum.photos/800/1007"),
                Story(imageURL: "https://picsum.photos/800/1008")
            ],
            previewUrl: "https://picsum.photos/800/1015",
            type: .photo,
            creator: Creator()
        )
        
        let story5 = StoryBundle(
            id: "1234565",
            stories: [
                Story(imageURL: "https://picsum.photos/800/1005"),
                Story(imageURL: "https://picsum.photos/800/1007"),
                Story(imageURL: "https://picsum.photos/800/1008")
            ],
            previewUrl: "https://picsum.photos/800/1017",
            type: .photo,
            creator: Creator()
        )
        
        let story6 = StoryBundle(
            id: "1263456",
            stories: [
                Story(imageURL: "https://picsum.photos/800/1006"),
                Story(imageURL: "https://picsum.photos/800/1007"),
                Story(imageURL: "https://picsum.photos/800/1008")
            ],
            previewUrl: "https://picsum.photos/800/1018",
            type: .photo,
            creator: Creator()
        )
        
        let story7 = StoryBundle(
            id: "12332456",
            stories: [
                Story(imageURL: "https://picsum.photos/800/1007"),
                Story(imageURL: "https://picsum.photos/800/1007"),
                Story(imageURL: "https://picsum.photos/800/1008")
            ],
            previewUrl: "https://picsum.photos/800/1024",
            type: .photo,
            creator: Creator()
        )
        
        let story8 = StoryBundle(
            id: "123453456",
            stories: [
                Story(imageURL: "https://picsum.photos/800/1008"),
                Story(imageURL: "https://picsum.photos/800/1007"),
                Story(imageURL: "https://picsum.photos/800/1008")
            ],
            previewUrl: "https://picsum.photos/800/1023",
            type: .photo,
            creator: Creator()
        )
        
        let story9 = StoryBundle(
            id: "1234422556",
            stories: [
                Story(imageURL: "https://picsum.photos/800/1009"),
                Story(imageURL: "https://picsum.photos/800/1007"),
                Story(imageURL: "https://picsum.photos/800/1008")
            ],
            previewUrl: "https://picsum.photos/800/1029",
            type: .photo,
            creator: Creator()
        )
        
        return [story1, story2, story3, story4, story5, story6, story7, story8, story9]
    }
}
