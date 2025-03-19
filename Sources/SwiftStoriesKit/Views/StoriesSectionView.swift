//
//  StoriesSectionView.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 16/3/25.
//

import SwiftUI

public struct StoriesSectionView: View {
    
    let storiesList: [StoryItemBundle]
    let storyNamespace: Namespace.ID
    let thumbnailNamespace: Namespace.ID
    
    @Binding var showStory: Bool
    @Binding var selectedStory: String
    
    
    public var body: some View {
        ScrollViewReader { scrollView in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(storiesList) { story in
                        ZStack{
                            Circle()
                                .opacity(0.001)
                            if !showStory || selectedStory != story.id {
                                ImageLoader(url: story.previewUrl)
                                    .matchedGeometryEffect(id: story.id, in: storyNamespace)
                                    .transition(.scale(scale: 0.99))
                                    .frame(width: 20, height: 20)
//                                    .foregroundStyle(Color.white.opacity(0.001))

                                    StoryThumbnailView(
                                        story: story,
                                        storyNamespace: storyNamespace,
                                        storyThumbnailNamespace: thumbnailNamespace,
                                        onLongPress: {},
                                        onClick: { onStoryClick(story: story) }
                                    )
                            }
                        }
                        .id(story.id)
                    }
                }
                
                .onChange(of: selectedStory){ storyId in
                    withAnimation(){
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
                            scrollView.scrollTo(storyId, anchor: .leading)
                        }
                    }
                }
                .onChange(of: selectedStory) {
                    print("\($0)")
                }
                
            }
        }
    }
    
    private func onStoryClick(story: StoryItemBundle){
        selectedStory = story.id
        withAnimation(.interactiveSpring(duration: 1.5)) {
            showStory = true
        }
    }
}

#Preview {
    StoriesSectionView(
        storiesList: DeveloperPreview.stories,
        storyNamespace: Namespace().wrappedValue,
        thumbnailNamespace: Namespace().wrappedValue,
        showStory: .constant(false),
        selectedStory: .constant("")
    )
    .frame(height: 120)
}
