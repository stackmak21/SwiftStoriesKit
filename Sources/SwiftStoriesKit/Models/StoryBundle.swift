//
//  StoryItemBundle.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 16/3/25.
//

import Foundation

public struct StoryBundle: Identifiable{
    
    public let id: String
    public let stories: [Story]
    public let previewUrl: String
    public let type: MediaType
    public let creator: Creator
    
    public init(
        id: String = "",
        stories: [Story] = [],
        previewUrl: String = "",
        type: MediaType = .photo,
        creator: Creator = Creator()
    ) {
        self.id = id
        self.stories = stories
        self.previewUrl = previewUrl
        self.type = type
        self.creator = creator
    }
}


public struct Story: Identifiable, Hashable {
    public var id: String = UUID().uuidString
    public let imageURL: String
}

