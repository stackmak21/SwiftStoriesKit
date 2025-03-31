//
//  StoryThumbnailItem.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 31/3/25.
//

import SwiftUI

struct StoryThumbnailItem: View {
    
    let story: StoryBundle
    
    @Binding var showStory: Bool
    @Binding var isInternalThumbnailShown: Bool
    @Binding var selectedStory: String
    
    var thumbnailNamespace: Namespace.ID
    var storyNamespace: Namespace.ID
    
    var body: some View {
        ZStack {
            ZStack{
                ImageLoaderRect(url: story.stories[story.currentStoryIndex].imageURL)
                    .matchedGeometryEffect(id: story.id, in: storyNamespace)
                    .frame(width: 20, height: 20)
            }

            ImageLoaderCircle(url: story.previewUrl)
                .matchedGeometryEffect(id: story.id, in: thumbnailNamespace)
                .frame(width: 60, height: 60)
            
        }
        .transition(.scale(scale: 0.99))
        .onDisappear {
            isInternalThumbnailShown = true
        }
        .onTapGesture {
            selectedStory = story.id
            DispatchQueue.main.asyncAfter(deadline: .now()){
                showStory = true
            }
        }
    }
}

#Preview {
    StoryThumbnailItem(
        story: DeveloperPreview.story,
        showStory: .constant(false),
        isInternalThumbnailShown: .constant(false),
        selectedStory: .constant(""),
        thumbnailNamespace: Namespace().wrappedValue,
        storyNamespace: Namespace().wrappedValue
    )
}
