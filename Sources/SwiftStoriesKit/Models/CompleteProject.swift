//
//  CompleteProject.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 17/3/25.
//

import SwiftUI
import Foundation


struct CompleteProject: View {
    
    @State var stories: [StoryBundle] = DeveloperPreview.stories
    @Namespace private var storyNamespace
    @Namespace private var thumbnailNamespace
    @State var showStory: Bool = false
    @State var selectedStory: String = ""
    @State var allow3dRotation: Bool = false
    
    var body: some View {
        ZStack{
            VStack{
//                    StoriesSectionView(
//                        storiesList: DeveloperPreview.stories,
//                        storyNamespace: storyNamespace,
//                        thumbnailNamespace: storyThumbnailNamespace,
//                        showStory: $showStory,
//                        selectedStory: $selectedStory
//                    )
                StoriesThumbnailListView(
                    storiesList: stories,
                    storyNamespace: storyNamespace,
                    thumbnailNamespace: thumbnailNamespace,
                    showStory: $showStory,
                    selectedStory: $selectedStory
                )
                
                
            }
            if showStory{
                StoriesView(
                    showStory: $showStory,
                    allow3DRotation: $allow3dRotation,
                    selectedStoryBundleID: $selectedStory,
                    storiesList: stories,
                    storyNamespace: storyNamespace,
                    thumbnailNamespace: thumbnailNamespace
                )
            }
        }
    }
}

#Preview {
    CompleteProject()
}
