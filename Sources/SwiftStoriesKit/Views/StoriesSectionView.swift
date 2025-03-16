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
                            if !showStory || selectedStory != story.id{
                                StoryThumbnailView(
                                    story: story,
                                    namespace: storyNamespace,
                                    onLongPress: {},
                                    onClick: { onStoryClick(story: story) }
                                )
                                .id(story.id)
                            }
                        }
                    }
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
        withAnimation(.easeInOut(duration: 0.1)) {
            showStory.toggle()
        }
    }
}

#Preview {
    StoriesSectionView(
        storiesList: DeveloperPreview.stories,
        storyNamespace: Namespace().wrappedValue,
        showStory: .constant(false),
        selectedStory: .constant("")
    )
    .frame(height: 120)
}
