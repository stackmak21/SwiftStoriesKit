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
    
    @Binding var isInternalShown: Bool
    
    
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
                                        
                                        ImageLoader(url: story.previewUrl)
                                        .matchedGeometryEffect(id: story.id, in: thumbnailNamespace)
                                        .frame(width: 100, height: 100)
                                    }
                                    .transition(.scale(scale: 0.99))
                                    .onDisappear {
                                        print("isInternalShown: \(isInternalShown)")
                                        isInternalShown = true
                                    }
                                    .onTapGesture {
                                        onStoryClick(story)
                                    }
                                }
                            }
                            .id(story.id)
                        }
                    }
                    Spacer()
                }
                .onChange(of: selectedStory){ scrollToLeading(scrollView, $0) }
            }
        }
        .animation(.spring(duration: 1.2), value: showStory)
    }
    
    private func onStoryClick(_ story: StoryBundle){
        selectedStory = story.id
        DispatchQueue.main.asyncAfter(deadline: .now()){
            withAnimation(.spring(duration: 1)) {
                
                showStory = true
            }
        }
    }
    
    private func scrollToLeading(_ scrollView: ScrollViewProxy, _ storyId: String){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3){
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
        selectedStory: .constant(""),
        isInternalShown: .constant(true)
    )
    .frame(height: 120)
}
