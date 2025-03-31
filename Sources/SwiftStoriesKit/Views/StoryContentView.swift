//
//  StoryContentView.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 31/3/25.
//

import SwiftUI

struct StoryContentView: View {
    
    let story: StoryBundle
    let geo: GeometryProxy
    
    @Binding var isInternalThumbnailShown: Bool
    @Binding var timerProgress: CGFloat
    
    var body: some View {
        ZStack {
            ImageLoaderRect(url: story.stories[story.currentStoryIndex].imageURL)
                .frame(width: geo.size.width, height: geo.size.height)
                .clipped()
            StoryHeaderView(
                story: story,
                isInternalThumbnailShown: $isInternalThumbnailShown,
                timerProgress: $timerProgress
            )
        }
    }
}
