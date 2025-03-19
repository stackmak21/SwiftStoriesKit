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
    let storyThumbnailNamespace: Namespace.ID
    
    @Binding var showStory: Bool
    @Binding var selectedStory: String
    
    
    public var body: some View {
        ScrollViewReader { scrollView in
            ScrollView(.horizontal, showsIndicators: false) {
                VStack{
                    HStack {
                        ForEach(storiesList) { story in
                            ZStack{
                                Rectangle()
                                    .frame(width: 100, height: 100)
                                if !showStory || selectedStory != story.id {
                                    ZStack{
                                        
                                        ImageLoader(url: story.previewUrl)
                                            .matchedGeometryEffect(id: story.id, in: storyNamespace)
                                            .frame(width: 20, height: 20)
                                        
                                        ImageLoader(url: story.previewUrl)
                                        //                                        .frame(width: 100, height: 100)
                                        //                                        .clipShape(Circle())
                                            .matchedGeometryEffect(id: story.id, in: storyThumbnailNamespace)
                                            .frame(width: 100, height: 100)
                                            .foregroundStyle(Color.black.opacity(1))
                                        
                                        
                                    }
                                    .transition(.scale(scale: 0.99))
                                    .onTapGesture {
                                        onStoryClick(story: story)
                                    }
                                    .id(story.id)
                                }
                            }
                        }
                    }
                    Spacer()
                }
                
//                .onChange(of: selectedStory){ storyId in
//                    withAnimation(){
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
//                            scrollView.scrollTo(storyId, anchor: .leading)
//                        }
//                    }
//                }
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
        storyThumbnailNamespace: Namespace().wrappedValue,
        showStory: .constant(false),
        selectedStory: .constant("")
    )
    .frame(height: 120)
}
