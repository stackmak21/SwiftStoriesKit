//
//  StoryCarousel.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 31/3/25.
//

import SwiftUI

public struct StoryCarousel: View {
    
    @Binding var storyBundles: [StoryBundle]
    
    @Binding var showStory: Bool
    @Binding var isInternalThumbnailShown: Bool
    @Binding var selectedStory: String
    
    var thumbnailNamespace: Namespace.ID
    var storyNamespace: Namespace.ID
    
    public var body: some View {
        
            // MARK: - Thumbnail Section
            ScrollView(.horizontal, showsIndicators: false){
                VStack{
                    HStack {
                        ForEach(storyBundles) { story in
                            
                            ZStack{
                                
                                Circle()
                                    .stroke(style: StrokeStyle(lineWidth: story.isStoryBundleSeen ? 2 : 3))
                                    .fill(LinearGradient(colors: story.isStoryBundleSeen ? [Color.gray] : [.pink, .pink, .red, .orange], startPoint: .topTrailing, endPoint: .bottomLeading))
                                    .scaledToFit()
                                    .frame(width: story.isStoryBundleSeen ? 66 : 67)
                                if !showStory  || selectedStory != story.id{
                                    StoryThumbnailItem(
                                        story: story,
                                        showStory: $showStory,
                                        isInternalThumbnailShown: $isInternalThumbnailShown,
                                        selectedStory: $selectedStory,
                                        thumbnailNamespace: thumbnailNamespace,
                                        storyNamespace: storyNamespace
                                    )
                                }
                            }
                        }
                    }
                    
                }
                .frame(height: 80)
            }
         
    }
}


#Preview {
    StoryCarousel(
        storyBundles: .constant(DeveloperPreview.stories),
        showStory: .constant(false),
        isInternalThumbnailShown: .constant(false),
        selectedStory: .constant(""),
        thumbnailNamespace: Namespace().wrappedValue,
        storyNamespace: Namespace().wrappedValue
    )
}
