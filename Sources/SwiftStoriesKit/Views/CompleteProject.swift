//
//  CompleteProject.swift
//  SwiftStoriesKit
//
//  Created by Paris Makris on 17/3/25.
//

import SwiftUI
import Foundation


struct CompleteProject: View {
    @Namespace private var storyNamespace
    @Namespace private var storyThumbnailNamespace
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
                    storiesList: DeveloperPreview.stories,
                    storyNamespace: storyNamespace,
                    storyThumbnailNamespace: storyThumbnailNamespace,
                    showStory: $showStory,
                    selectedStory: $selectedStory
                )
                Spacer()
            }
            if showStory{
                StoriesView(
                    showStory: $showStory,
                    allow3dRotation: $allow3dRotation,
                    selectedStory: $selectedStory,
                    storiesList: DeveloperPreview.stories,
                    storyNamespace: storyNamespace,
                    storyThumbnailNamespace: storyThumbnailNamespace
                )
            }
        }
    }
}

#Preview {
    CompleteProject()
}
