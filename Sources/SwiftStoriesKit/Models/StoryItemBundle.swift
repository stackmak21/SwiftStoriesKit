//
//  StoryItemBundle.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 16/3/25.
//

public struct StoryItemBundle: Identifiable{
    
   public let id: String
   public let url: [String]
   public let previewUrl: String
   public let type: MediaType
   public let creator: Creator
    
    public init(
        id: String = "",
        url: [String] = [],
        previewUrl: String = "",
        type: MediaType = .photo,
        creator: Creator = Creator()
    ) {
        self.id = id
        self.url = url
        self.previewUrl = previewUrl
        self.type = type
        self.creator = creator
    }
}
