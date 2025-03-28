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
            id: "1",
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
        var storiesList: [StoryBundle] = []
        
        for i in 1...9 {
            var stories: [Story] = []
            for j in 1...3{
                stories.append(Story(imageURL: "https://picsum.photos/800/11\(i)\(j)"))
            }
            let story = StoryBundle(id: "\(i)", stories: stories, previewUrl: "https://picsum.photos/801/100\(i)", type: .photo, creator: Creator())
            storiesList.append(story)
        }
        return storiesList
    }
    
    public static var stories1: [StoryBundle] {
        let story1 = StoryBundle(
            id: "1",
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
            id: "2",
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
            id: "3",
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
            id: "4",
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
            id: "5",
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
            id: "6",
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
