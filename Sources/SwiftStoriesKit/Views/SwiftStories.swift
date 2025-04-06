//
//  SwiftStories.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 31/3/25.
//

import SwiftUI

import SwiftUI

public struct SwiftStories: View {
    @State var stories: [StoryBundle] = StoriesDeveloperPreview.stories
    
    @Namespace private var thumbnailNamespace
    @Namespace private var storyNamespace
    
    @State private var selectedStory: String = ""
    @State private var showStory: Bool = false
    
    @State private var isInternalThumbnailShown: Bool = false

    @State private var offsetY: CGFloat = 0
    @State private var scale: CGFloat = 1
    @State private var opacity: Double = 1
    @State private var showInfo: Bool = false
    
    @State var timerProgress: CGFloat = 0
    
    private let deviceHeight: Double = UIScreen.self.main.bounds.height
    
    public init() {}
    
    public var body: some View {
        ZStack {
            
            StoryCarousel(
                storyBundles: $stories,
                showStory: $showStory,
                isInternalThumbnailShown: $isInternalThumbnailShown,
                selectedStory: $selectedStory,
                thumbnailNamespace: thumbnailNamespace,
                storyNamespace: storyNamespace
            )
            
            // MARK: - Fullscreen Story Viewer
            Color.black.opacity(showStory ? opacity : 0).ignoresSafeArea()
            
//            Button(
//                action: {
//                    stories.sort(by: {!$0.isStoryBundleSeen && $1.isStoryBundleSeen})
//                },
//                label: {
//                    Text("Refresh")
//                })
            
            if showStory {
                
                    
                    StoryFullScreenViewer(
                        storiesBundle: $stories,
                        opacity: $opacity,
                        showStory: $showStory,
                        isInternalThumbnailShown: $isInternalThumbnailShown,
                        selectedStory: $selectedStory,
                        timerProgress: $timerProgress,
                        thumbnailNamespace: thumbnailNamespace,
                        storyNamespace: storyNamespace
                    )
                
            }
        }
        .animation(.spring(duration: 0.14), value: showStory)
        
    }
    

}

#Preview {
    SwiftStories()
}
