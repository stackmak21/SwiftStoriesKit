//
//  StoriesThumbnailListView.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 17/3/25.
//

import SwiftUI

public struct StoriesThumbnailListView: View {
    
    let storiesList: [StoryItemBundle]
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
                                        
                                        ImageLoaderRect(url: story.previewUrl)
                                            .matchedGeometryEffect(id: story.id, in: storyNamespace)
                                            .frame(width: 20, height: 20)
                                        
                                        StoryThumbnailView(
                                            story: story,
                                            thumbnailNamespace: thumbnailNamespace,
                                            onLongPress: {},
                                            onClick: {onStoryClick(story: story)}
                                        )
                                        .frame(width: 100, height: 100)
                                        .zIndex(1)
//                                        ImageLoader(url: story.previewUrl)
//                                            .matchedGeometryEffect(id: story.id, in: thumbnailNamespace)
//                                            .frame(width: 100, height: 100)
                                        
                                        
                                    }
                                    .transition(.scale(scale: 0.99))
                                    .onTapGesture {
                                        
                                    }
                                    .id(story.id)
                                }
                            }
                        }
                    }
                    Spacer()
                }
                
                .onChange(of: selectedStory){ storyId in
                    withAnimation(){
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
                            scrollView.scrollTo(storyId, anchor: .leading)
                        }
                    }
                }
            }
        }
    }
    
    private func onStoryClick(story: StoryItemBundle){
        selectedStory = story.id
        withAnimation(.interpolatingSpring(duration: 0.2)) {
            showStory = true
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
