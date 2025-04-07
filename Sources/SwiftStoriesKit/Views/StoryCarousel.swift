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
    
    public init(
        storyBundles: Binding<[StoryBundle]>,
        showStory: Binding<Bool>,
        isInternalThumbnailShown: Binding<Bool>,
        selectedStory: Binding<String>,
        thumbnailNamespace: Namespace.ID,
        storyNamespace: Namespace.ID
    ) {
        self._storyBundles = storyBundles
        self._showStory = showStory
        self._isInternalThumbnailShown = isInternalThumbnailShown
        self._selectedStory = selectedStory
        self.thumbnailNamespace = thumbnailNamespace
        self.storyNamespace = storyNamespace
    }
    
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
                    Spacer()
                }
            }
         
    }
}


#Preview {
    StoryCarousel(
        storyBundles: .constant(StoriesDeveloperPreview.stories),
        showStory: .constant(false),
        isInternalThumbnailShown: .constant(false),
        selectedStory: .constant(""),
        thumbnailNamespace: Namespace().wrappedValue,
        storyNamespace: Namespace().wrappedValue
    )
}
