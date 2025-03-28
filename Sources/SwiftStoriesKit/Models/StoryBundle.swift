//
//  StoryItemBundle.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 16/3/25.
//

import Foundation

public struct StoryBundle: Identifiable{
    
    public let id: String
    public var stories: [Story]
    public let previewUrl: String
    public let type: MediaType
    public let creator: Creator
    public var currentStoryIndex: Int
    public var storyTimer: CGFloat
    public var isStoryBundleSeen: Bool {
        var isSeen: Bool = true
        stories.forEach { story in
            if !story.isSeen {
                isSeen = false
            }
        }
        return isSeen
    }
    
    public init(
        id: String = "",
        stories: [Story] = [],
        previewUrl: String = "",
        type: MediaType = .photo,
        creator: Creator = Creator(),
        currentStoryIndex: Int = 0,
        storyTimer: CGFloat = 0
    ) {
        self.id = id
        self.stories = stories
        self.previewUrl = previewUrl
        self.type = type
        self.creator = creator
        self.currentStoryIndex = currentStoryIndex
        self.storyTimer = storyTimer
    }
    
    public mutating func goToNextStory() {
        if currentStoryIndex < stories.count - 1 {
            currentStoryIndex += 1
            stories[currentStoryIndex].isSeen = true
        }
    }
    
    public mutating func goToPreviousStory() {
        if currentStoryIndex > 0 {
            currentStoryIndex -= 1
//            storyTimer = CGFloat(currentStoryIndex)
        }
    }
    
    public mutating func goToNextStory(with index: Int) {
        if currentStoryIndex < stories.count - 1 {
            currentStoryIndex = index
//            storyTimer = CGFloat(currentStoryIndex)
        }
    }
    
    public mutating func setTime(){
        storyTimer += 0.01
    }
}


public struct Story: Identifiable, Hashable {
    public var id: String = UUID().uuidString
    public let imageURL: String
    public var isSeen: Bool
    
    init(imageURL: String, isSeen: Bool = false) {
        self.imageURL = imageURL
        self.isSeen = isSeen
    }
    
    public mutating func storyShowed(){
        isSeen = true
    }
}

