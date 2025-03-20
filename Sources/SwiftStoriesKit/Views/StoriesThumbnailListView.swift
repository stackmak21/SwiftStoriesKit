//
//  StoriesThumbnailListView.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 17/3/25.
//

import SwiftUI

public struct StoriesThumbnailListView: View {
    
    let storiesList: [StoryBundle]
    let storyNamespace: Namespace.ID
    let thumbnailNamespace: Namespace.ID
    
    @Binding var showStory: Bool
    @Binding var selectedStory: String
    
    
    public var body: some View {
        ScrollViewReader { scrollView in
            ScrollView(.horizontal, showsIndicators: false) {
                VStack{
                    HStack {
                        ForEach(storiesList) { story in
                            ZStack{
                                Circle()
                                    .frame(width: 100, height: 100)
                                if !showStory || selectedStory != story.id {
                                    ZStack{
                                        ImageLoaderRect(url: story.stories[0].imageURL)
                                            .matchedGeometryEffect(id: story.id, in: storyNamespace)
                                            .frame(width: 20, height: 20)
                                        
                                        StoryThumbnailView(
                                            story: story,
                                            thumbnailNamespace: thumbnailNamespace,
                                            onLongPress: {},
                                            onClick: {onStoryClick(story)}
                                        )
                                        .frame(width: 100, height: 100)
                                    }
                                    .transition(.scale(scale: 0.99))
                                    .id(story.id)
                                }
                            }
                        }
                    }
                    Spacer()
                }
                
                .onChange(of: selectedStory){ scrollToLeading(scrollView, $0) }
            }
        }
    }
    
    private func onStoryClick(_ story: StoryBundle){
        selectedStory = story.id
        withAnimation(.interpolatingSpring(duration: 0.2)) {
            showStory = true
        }
    }
    
    private func scrollToLeading(_ scrollView: ScrollViewProxy, _ storyId: String){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            scrollView.scrollTo(storyId, anchor: .leading)
        }
    }
}

#Preview {
    StoriesThumbnailListView(
        storiesList: DeveloperPreview.stories,
        storyNamespace: Namespace().wrappedValue,
        thumbnailNamespace: Namespace().wrappedValue,
        showStory: .constant(false),
        selectedStory: .constant("")
    )
    .frame(height: 120)
}
