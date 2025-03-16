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
    @State var showStory: Bool = false
    @State var selectedStory: String = ""
    @State var allow3dRotation: Bool = false
    
    var body: some View {
        ZStack{
            VStack{
                StoriesSectionView(
                    storiesList: DeveloperPreview.stories,
                    storyNamespace: storyNamespace,
                    showStory: $showStory,
                    selectedStory: $selectedStory
                )
                .frame(height: 100)
            }
            if showStory{
                StoriesView(
                    showStory: $showStory,
                    allow3dRotation: $allow3dRotation,
                    selectedStory: $selectedStory,
                    storiesList: DeveloperPreview.stories,
                    storyNamespace: storyNamespace
                )
            }
        }
    }
}

#Preview {
    CompleteProject()
}
